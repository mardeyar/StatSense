import 'package:nhl/api/nhl_api.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

import '../model/games.dart';
import '../model/team.dart';
import '../utils/date_utils.dart';

class FunctionManager {

  // Global variables because values from different methods need to be stored at different times
  late List<GameDate> scheduledGames = [];
  late Map<String, Team> teamMap = {};

  /**
   * Writes the data retrieved from fetchGameData & fetchTeams methods and writes
   * to a json file stored in the data folder.
   */
  Future<void> writeDataFromAPI() async {

    // Call these methods to first gather the data from API then write to json
    await fetchGameData();
    await fetchTeamStats();
    await calculateStreamScores();
    final gameJson = scheduledGames.map((gameDate) => gameDate.toJson()).toList();
    final teamJson = teamMap.map((key, value) => MapEntry(key, value.toJson()));

    // Map to represent data saved to file
    final savedData = {
      'gameDates': gameJson,
      'teamMap': teamJson,
    };

    final jsonData = jsonEncode(savedData);

    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/data/appdata.json');

      // File won't be there on first run or cache clear, check if file exists
      if (!await file.exists()) {
        await file.create(recursive: true);
      }

      await file.writeAsString(jsonData);
    } catch (e) {
      print('Write Error: $e');
    }
  }

  /**
   * Reads the data that writeDataFromAPI stores. This is to store data locally
   * to avoid sending API calls for every screen redraw.
   */
  Future<void> readDataFromFile() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/data/appdata.json');

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        // With decoding, need to use UTF-8 specifically for Montréal Canadiens because of the 'é'
        final decodeData = json.decode(utf8.decode(jsonData.codeUnits));

        // Update gameDates & teamMap with decoded json data
        scheduledGames = (decodeData['gameDates'] as List)
            .map((gameJson) => GameDate.fromJson(gameJson))
            .toList();

        final Map<String, dynamic> decodedMap = decodeData['teamMap'] as Map<String, dynamic>;
        teamMap = decodedMap.map((key, value) => MapEntry(key, Team.fromJson(value)),
        );
      } else {
        print('File does not exist');
      }
    } catch (e) {
      print('Error reading: $e');
    }
  }

  /**
   * Parses the NHL API to retrieve select attributes that make up a 'game'
   * or a 'team' object.
   */
  Future<void> fetchGameData() async {
    final DateTime today = DateTime.now();
    final DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));
    final formattedDate = DateUtils.formatWeekStartDate(weekStart);

    try {
      final scheduleData = await NHLApi.fetchScheduleData(formattedDate);
      final List<dynamic> gameWeek = scheduleData['gameWeek'];

      // Process data from API call
      scheduledGames = gameWeek.map((gameData) {
        final List<Game> games = [];
        final List<dynamic> gamesData = gameData['games'];
        final bool offDay = gameData['numberOfGames'] >= 1 && gameData['numberOfGames'] <= 7;

        // Iterate through today's games and add to gameList
        for (var game in gamesData) {
          games.add(Game(
            date: game['startTimeUTC'],
            awayTeam: game['awayTeam']['abbrev'],
            homeTeam: game['homeTeam']['abbrev'],
          ));

          setTeamScheduleValues(game['awayTeam']['abbrev'], offDay);
          setTeamScheduleValues(game['homeTeam']['abbrev'], offDay);
        }

        // Creates a gameDate object for each day, storing the data in a gameList
        return GameDate(
          date: gameData['date'],
          numberOfGames: gameData['numberOfGames'],
          offDay: offDay,
          gameList: games,
        );
      }).toList();
    } catch (e) {
      print('Failed to load schedule data: $e');
    }
  }

  /**
   * Sets a few attributes for a team object from data that is only found in the
   * scheduling part of the NHL API call.<br>
   * <br>[teamAbbrev] Used to dynamically assign 'totalGames' & 'offDays' attributes by using a teams abbreviation.<br>
   * <br>[offDay] Increments a team objects 'offDay' attribute count if they're playing on a day with < 8 games played.
   */
  void setTeamScheduleValues(String teamAbbrev, bool offDay) {
    if (!teamMap.containsKey(teamAbbrev)) {
      teamMap[teamAbbrev] = Team(
        teamName: teamAbbrev,
        totalGames: 0,
        offDays: 0,
        gameDates: [],
      );
    }
    teamMap[teamAbbrev]!.totalGames++;
    if (offDay) {
      teamMap[teamAbbrev]!.offDays++;
    }
  }

  /** Parses the NHL API standings endpoint to retrieve data needed to set attributes
   * for a team object. */
  Future<void> fetchTeamStats() async {
    try {
      final teamData = await NHLApi.fetchTeamStats();
      final List<dynamic> allTeams = teamData['standings'];

      for (var teamData in allTeams) {
        final teamAbbrev = teamData['teamAbbrev']['default'];

        if (teamMap.containsKey(teamAbbrev)) {
          final team = teamMap[teamAbbrev]!;
          team.teamName = teamData['teamName']['default'];
          team.teamAbbrev = teamData['teamAbbrev']['default'];
          team.conference = teamData['conferenceName'];
          team.division = teamData['divisionName'];
          team.gamesPlayed = teamData['gamesPlayed'];
          team.goalDiff = teamData['goalDifferential'];
          team.goalsAgainst = teamData['goalAgainst'];
          team.goalsFor = teamData['goalFor'];
          team.last10GoalDiff = teamData['l10GoalDifferential'];
          team.last10GoalsFor = teamData['l10GoalsFor'];
          team.last10GoalsAgainst = teamData['l10GoalsAgainst'];
          team.last10Losses = teamData['l10Losses'];
          team.last10Wins = teamData['l10Wins'];
          team.last10OTL = teamData['l10OtLosses'];
          team.last10Points = teamData['l10Points'];
          team.totalLosses = teamData['losses'];
          team.totalWins = teamData['wins'];
          team.totalOTL = teamData['otLosses'];
          team.streakCode = teamData['streakCode'];
          team.streakCount = teamData['streakCount'];
        }
      }
    } catch (e) {
      print('Failed to load team stats: $e');
    }
  }

  /**
   * Runs some if statements to give an analysis on a teams performance over last
   * 10 games using data gathered by fetchTeams method.<br>
   * <br>[team]: Object to get the analysis about<br>
   * <br>returns: String trend analysis of teams performance based on points
   */
  String getTrendingAnalysis(Team team) {
    if (team.last10Points >= 0 && team.last10Points <= 3) {
      return "The ${team.teamName} have been pretty bad recently, mustering just "
          "${team.last10Points} points in their past 10 games and a ${team.last10Wins}-"
          "${team.last10Losses}-${team.last10OTL} record.";
    } else if (team.last10Points >= 4 && team.last10Points <= 7) {
      return "The ${team.teamName} have been pretty cold of late, gaining only ${team.last10Points} "
          "points in their past 10 games with a record of ${team.last10Wins}-${team.last10Losses}-${team.last10OTL}.";
    } else if (team.last10Points >= 8 && team.last10Points <= 11) {
      return "The ${team.teamName} have been lukewarm, getting ${team.last10Points} "
          "points in their past 10 games with a record of ${team.last10Wins}-${team.last10Losses}-${team.last10OTL}.";
    } else if (team.last10Points >= 12 && team.last10Points <= 15) {
      return "The ${team.teamName} have been playing some good hockey, gaining ${team.last10Points} "
          "points in their past 10 games with a record of ${team.last10Wins}-${team.last10Losses}-${team.last10OTL}.";
    } else if (team.last10Points >= 16 && team.last10Points <= 20) {
      return "The ${team.teamName} have been running hot lately, getting points in "
          "${team.last10Wins + team.last10OTL} of their last 10 games, good for ${team.last10Points} "
          "points. They have a ${team.last10Wins}-${team.last10Losses}-${team.last10OTL} "
          "record in their last 10.";
    } else {
      return "The program broke, this text should never have been shown";
    }
  }

  /**
   * Calculate a streamerScore using formula based on values of team attributes
   */
  Future<dynamic> calculateStreamScores() async {
    for (final team in teamMap.values) {
      final offDaysWeight = team.offDays * 0.95;
      final gameWeight = team.totalGames * 0.90;
      final trendScore = team.getTrendScore();
      final pctScore = (offDaysWeight + gameWeight + trendScore) * 10;

      team.streamerScore = pctScore * 1.3;
    }
  }
}