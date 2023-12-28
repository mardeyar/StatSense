// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../model/team.dart';
// import '../model/players.dart';
//
// class TeamManager {
//   List<Team> teamList = [];
//   List<Player> playerList = [];
//
//   Future<void> fetchTeams() async {
//     // Fetch the teams data from the NHL API
//     final teamResponse = await http.get(
//       Uri.parse('https://api-web.nhle.com/v1/standings/now'),
//     );
//
//     if (teamResponse.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(teamResponse.body);
//       final List<dynamic> allTeams = responseData['standings'];
//
//       // Process the data from the team retrieval API call
//       teamList = await Future.wait(
//           allTeams.map((teamData) async {
//             var team = Team(
//               teamName: teamData['teamName']['default'],
//               teamAbbrev: teamData['teamAbbrev']['default'],
//               conference: teamData['conferenceName'],
//               division: teamData['divisionName'],
//               gamesPlayed: teamData['gamesPlayed'],
//               goalDiff: teamData['goalDifferential'],
//               goalsAgainst: teamData['goalAgainst'],
//               goalsFor: teamData['goalFor'],
//               homeGoalDiff: teamData['homeGoalDifferential'],
//               homeGoalsAgainst: teamData['homeGoalsAgainst'],
//               homeGoalsFor: teamData['homeGoalsFor'],
//               homeLosses: teamData['homeLosses'],
//               homeWins: teamData['homeWins'],
//               homeOTL: teamData['homeOtLosses'],
//               last10GoalDiff: teamData['l10GoalDifferential'],
//               last10GoalsFor: teamData['l10GoalsFor'],
//               last10GoalsAgainst: teamData['l10GoalsAgainst'],
//               last10Losses: teamData['l10Losses'],
//               last10Wins: teamData['l10Wins'],
//               last10OTL: teamData['l10OtLosses'],
//               last10Points: teamData['l10Points'],
//               totalLosses: teamData['losses'],
//               totalWins: teamData['wins'],
//               totalOTL: teamData['otLosses'],
//               roadGoalDiff: teamData['roadGoalDifferential'],
//               roadGoalsAgainst: teamData['roadGoalsAgainst'],
//               roadGoalsFor: teamData['roadGoalsFor'],
//               roadLosses: teamData['roadLosses'],
//               roadWins: teamData['roadWins'],
//               roadOTL: teamData['roadOtLosses'],
//               streakCode: teamData['streakCode'],
//               streakCount: teamData['streakCount'],
//             );
//
//             print('fetch ${team.teamAbbrev}: ${team.last10Points}');
//             await fetchRoster(team);
//             return team;
//           }),
//       );
//     } else {
//       throw Exception('Failed to load NHL teams data...');
//     }
//   }
//
//   // Method to extract the playerID and add to the roster list
//   Future<void> fetchRoster(Team team) async {
//     final playerResponse = await http.get(
//         Uri.parse('https://api-web.nhle.com/v1/roster/${team.teamAbbrev}/current')
//     );
//
//     if (playerResponse.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(playerResponse.body);
//       final List<dynamic> forwards = responseData['forwards'];
//       final List<dynamic> defensemen = responseData['defensemen'];
//
//       // Loop through to add all these playerID into the roster list
//       for (var player in [...forwards, ...defensemen]) {
//         team.roster.add(player['id']);
//       }
//     } else {
//       throw Exception('Error: failed to load playerIDs for ${team.teamName}');
//     }
//   }
//
//   // String method to show a quick summary of the teams recent performance
//   String getTrendingAnalysis(Team team) {
//     if (team.last10Points >= 0 && team.last10Points <= 7) {
//       return "The ${team.teamName} have been a bit cold recently, mustering just "
//           "${team.last10Points} points in their past 10 games and a ${team.last10Wins} - "
//           "${team.last10Losses} - ${team.last10OTL} record.";
//     } else if (team.last10Points >= 8 && team.last10Points <= 13) {
//       return "The ${team.teamName} have been playing some good hockey, gaining ${team.last10Points} "
//           "points in their past 10 games with a record of ${team.last10Wins} - ${team.last10Losses} - ${team.last10OTL}.";
//     } else if (team.last10Points >= 14 && team.last10Points <= 20) {
//       return "The ${team.teamName} have been running hot lately, getting points in "
//           "(${team.last10Wins} + ${team.last10OTL}) of their last 10 games, good for ${team.last10Points} "
//           "points. They have a ${team.last10Wins} - ${team.last10Losses} - ${team.last10OTL} "
//           "record in their last 10.";
//     } else {
//       return "The program broke, this text should never have been shown";
//     }
//   }
//
//   void calculateStreamScores(Map<String, Team> teamMap) {
//     for (final team in teamMap.values) {
//       final offDaysWeight = team.offDays * 0.10;
//       final gameWeight = team.totalGames * 0.15;
//       final trendScore = team.last10Points * .1;
//
//       // Can probably tweak this method of weighting the streamerScore
//       final weightedScore = (gameWeight + offDaysWeight) * team.totalGames;
//       team.streamerScore = weightedScore + trendScore;
//       print('stream ${team.teamName}: ${team.last10Points}');
//     }
//   }
// }