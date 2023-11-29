import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/games.dart';
import '../utils/date_utils.dart';

class GameManager {
  late List<GameDate> gameDates = [];
  late Map<String, Team> teamMap = {};

  Future<void> fetchGameData() async {
    final DateTime today = DateTime.now();
    final DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));
    final formattedDate = DateUtils.formatWeekStartDate(weekStart);

    final response = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/schedule/$formattedDate'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> gameWeek = responseData['gameWeek'];

      gameDates = gameWeek.map((gameData) {
        final List<Game> games = [];
        final List<dynamic> gamesData = gameData['games'];
        final bool offDay = gameData['numberOfGames'] >= 1 && gameData['numberOfGames'] <= 7;

        for (var game in gamesData) {
          games.add(Game(
            date: game['startTimeUTC'],
            awayTeam: game['awayTeam']['abbrev'],
            homeTeam: game['homeTeam']['abbrev'],
          ));

          updateTeamData(game['awayTeam']['abbrev'], offDay);
          updateTeamData(game['homeTeam']['abbrev'], offDay);
        }

        return GameDate(
          date: gameData['date'],
          numberOfGames: gameData['numberOfGames'],
          offDay: offDay,
          gameList: games,
        );
      }).toList();

      countOffDays();
      //calculateStreamScores();
    } else {
      throw Exception('Failed to load NHL Game data.');
    }
  }

  void updateTeamData(String teamAbbrev, bool offDay) {
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

  void countOffDays() {
    final Map<String, int> gamesPerDay = {};
    for (final date in gameDates) {
      gamesPerDay[date.date] = date.numberOfGames;
    }

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
    calculateStreamScores();
  }

  void calculateStreamScores() {
    for (final team in teamMap.values) {
      final offDaysWeight = team.offDays * 0.10;
      final gameWeight = team.totalGames * 0.15;

      final weightedScore = (gameWeight + offDaysWeight) * team.totalGames;
      team.streamerScore = weightedScore;
    }
  }
}