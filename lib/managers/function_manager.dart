import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

import '../model/games.dart';
import '../model/team.dart';
import '../utils/date_utils.dart';

class FunctionManager {
  late List<GameDate> gameDates = [];
  late Map<String, Team> teamMap = {};

  // Write the game/team data to a json file for quicker app speed, saves network requests
  Future<void> writeData() async {
    await fetchGameData();
    await fetchTeams();

    final gameJson = gameDates.map((gameDate) => gameDate.toJson()).toList();
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

      await file.writeAsString(jsonData);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> readData() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/data/appdata.json');

      if (await file.exists()) {
        final jsonData = await file.readAsString();
        // With decoding, need to use UTF-8 specifically for Montréal Canadiens because of the 'é'
        final decodeData = json.decode(utf8.decode(jsonData.codeUnits));

        // Update gameDates & teamMap with decoded json data
        gameDates = (decodeData['gameDates'] as List)
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

  // This method retrieves all game data for specified week
  Future<void> fetchGameData() async {
    final DateTime today = DateTime.now();
    final DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));
    final formattedDate = DateUtils.formatWeekStartDate(weekStart);

    // Fetch the data from the NHL API
    final response = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/schedule/$formattedDate'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> gameWeek = responseData['gameWeek'];

      // Process data from API call
      gameDates = gameWeek.map((gameData) {
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

      // Get the rest of the attributes needed to make up a team object
      // This is a hacky way, I'm sure there's a better way
      await fetchTeams();
      setTeamOffDays();
      calculateStreamScores();

    } else {
      throw Exception('Failed to load NHL Game data.');
    }
  }

  void setTeamScheduleValues(String teamAbbrev, bool offDay) {
    if (!teamMap.containsKey(teamAbbrev)) {
      teamMap[teamAbbrev] = Team(
        teamName: teamAbbrev,
        totalGames: 0,
        offDays: 0,
        streamerScore: 0,
        gameDates: [],
      );
    }
    teamMap[teamAbbrev]!.totalGames++;
    if (offDay) {
      teamMap[teamAbbrev]!.offDays++;
    }
  }

  void setTeamOffDays() async {
    final Map<String, int> gamesPerDay = {};
    for (final date in gameDates) {
      gamesPerDay[date.date] = date.numberOfGames;
    }

    /*
     * This section of code goes through each team's game schedule to count games played on offDays.
     * It looks at the number of games set for each date, checking if it's within offDay range (1 to 7).
     * Then, it checks if a team has a game on that date. If they do, it increments offDay count.
    */
    for (final team in teamMap.values) {
      for (final date in gamesPerDay.keys) {
        final todayGames = gamesPerDay[date]!;
        if (todayGames > 0 && todayGames < 8) {
          if (team.gameDates.contains(date)) {
            team.offDays++;
          }
        }
      }
    }
  }

  Future<void> fetchTeams() async {
    // Fetch the teams data from the NHL API
    final teamResponse = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/standings/now'),
    );

    if (teamResponse.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(teamResponse.body);
      final List<dynamic> allTeams = responseData['standings'];

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
    } else {
      throw Exception('Failed to load NHL teams data...');
    }
  }

  // String method to show a quick summary of the teams recent performance
  String getTrendingAnalysis(Team team) {
    if (team.last10Points >= 0 && team.last10Points <= 7) {
      return "The ${team.teamName} have been a bit cold recently, mustering just "
          "${team.last10Points} points in their past 10 games and a ${team.last10Wins} - "
          "${team.last10Losses} - ${team.last10OTL} record.";
    } else if (team.last10Points >= 8 && team.last10Points <= 13) {
      return "The ${team.teamName} have been playing some good hockey, gaining ${team.last10Points} "
          "points in their past 10 games with a record of ${team.last10Wins} - ${team.last10Losses} - ${team.last10OTL}.";
    } else if (team.last10Points >= 14 && team.last10Points <= 20) {
      return "The ${team.teamName} have been running hot lately, getting points in "
          "(${team.last10Wins} + ${team.last10OTL}) of their last 10 games, good for ${team.last10Points} "
          "points. They have a ${team.last10Wins} - ${team.last10Losses} - ${team.last10OTL} "
          "record in their last 10.";
    } else {
      return "The program broke, this text should never have been shown";
    }
  }

  void calculateStreamScores() {
    for (final team in teamMap.values) {
      final offDaysWeight = team.offDays * 1.5;
      final gameWeight = team.totalGames * 0.75;
      final trendScore = ((team.last10Points * 0.05) + (team.last10Wins * 0.05)
      + (team.last10GoalDiff * 0.2) - (team.last10Losses * 0.02)) * 0.2;
      print('$trendScore');

      // Can probably tweak this method of weighting the streamerScore
      final weightedScore = (gameWeight + offDaysWeight) * team.offDays;
      team.streamerScore = weightedScore + trendScore;
    }
  }
}