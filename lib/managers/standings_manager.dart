import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/standings.dart';

class StandingsManager {
  List<Team> teamList = [];

  Future<void> fetchTeams() async {

    // Fetch the teams data from the NHL API
    final teamResponse = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/standings/now'),
    );

    if (teamResponse.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(teamResponse.body);
      final List<dynamic> allTeams = responseData['standings'];

      // Process the data from the team retrieval API call
      teamList = allTeams.map((teamData) {
        return Team(
          teamName: teamData['teamName']['default'],
          teamAbbrev: teamData['teamAbbrev']['default'],
          conference: teamData['conferenceName'],
          division: teamData['divisionName'],
          gamesPlayed: teamData['gamesPlayed'],
          goalDiff: teamData['goalDifferential'],
          goalsAgainst: teamData['goalAgainst'],
          goalsFor: teamData['goalFor'],
          homeGoalDiff: teamData['homeGoalDifferential'],
          homeGoalsAgainst: teamData['homeGoalsAgainst'],
          homeGoalsFor: teamData['homeGoalsFor'],
          homeLosses: teamData['homeLosses'],
          homeWins: teamData['homeWins'],
          homeOTL: teamData['homeOtLosses'],
          last10GoalDiff: teamData['l10GoalDifferential'],
          last10GoalsFor: teamData['l10GoalsFor'],
          last10GoalsAgainst: teamData['l10GoalsAgainst'],
          last10Losses: teamData['l10Losses'],
          last10Wins: teamData['l10Wins'],
          last10OTL: teamData['l10OtLosses'],
          totalLosses: teamData['losses'],
          totalWins: teamData['wins'],
          totalOTL: teamData['otLosses'],
          roadGoalDiff: teamData['roadGoalDifferential'],
          roadGoalsAgainst: teamData['roadGoalsAgainst'],
          roadGoalsFor: teamData['roadGoalsFor'],
          roadLosses: teamData['roadLosses'],
          roadWins: teamData['roadWins'],
          roadOTL: teamData['roadOtLosses'],
          streakCode: teamData['streakCode'],
          streakCount: teamData['streakCount'],
          //teamLogoURL: teamData['teamLogo'],
        );
      }).toList();
    } else {
      throw Exception('Failed to load NHL teams data.');
    }
  }
}