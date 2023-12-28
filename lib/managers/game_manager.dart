// import 'package:http/http.dart' as http;
// import 'package:nhl/managers/team_manager.dart';
// import 'dart:convert';
//
// import '../model/games.dart';
// import '../model/team.dart';
// import '../utils/date_utils.dart';
//
// class GameManager {
//   late List<GameDate> gameDates = [];
//   late Map<String, Team> teamMap = {};
//
//   // This method retrieves all game data for specified week
//   Future<void> fetchGameData() async {
//     final DateTime today = DateTime.now();
//     final DateTime weekStart = today.subtract(Duration(days: today.weekday - 1));
//     final formattedDate = DateUtils.formatWeekStartDate(weekStart);
//
//     // Fetch the data from the NHL API
//     final response = await http.get(
//       Uri.parse('https://api-web.nhle.com/v1/schedule/$formattedDate'),
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final List<dynamic> gameWeek = responseData['gameWeek'];
//
//       // Process data from API call
//       gameDates = gameWeek.map((gameData) {
//         final List<Game> games = [];
//         final List<dynamic> gamesData = gameData['games'];
//         final bool offDay = gameData['numberOfGames'] >= 1 && gameData['numberOfGames'] <= 7;
//
//         // Iterate through today's games and add to gameList
//         for (var game in gamesData) {
//           games.add(Game(
//             date: game['startTimeUTC'],
//             awayTeam: game['awayTeam']['abbrev'],
//             homeTeam: game['homeTeam']['abbrev'],
//           ));
//
//           setTeamScheduleValues(game['awayTeam']['abbrev'], offDay);
//           setTeamScheduleValues(game['homeTeam']['abbrev'], offDay);
//         }
//
//         // Creates a gameDate object for each day, storing the data in a gameList
//         return GameDate(
//           date: gameData['date'],
//           numberOfGames: gameData['numberOfGames'],
//           offDay: offDay,
//           gameList: games,
//         );
//       }).toList();
//
//       // Set the offDays attribute for the team object
//       setTeamOffDays();
//
//       await TeamManager().fetchTeams();
//       TeamManager().calculateStreamScores(teamMap);
//     } else {
//       throw Exception('Failed to load NHL Game data.');
//     }
//   }
//
//   void setTeamScheduleValues(String teamAbbrev, bool offDay) {
//     if (!teamMap.containsKey(teamAbbrev)) {
//       teamMap[teamAbbrev] = Team(
//         teamName: teamAbbrev,
//         totalGames: 0,
//         offDays: 0,
//         streamerScore: 0,
//         gameDates: [],
//       );
//     }
//     teamMap[teamAbbrev]!.totalGames++;
//     if (offDay) {
//       teamMap[teamAbbrev]!.offDays++;
//     }
//   }
//
//   void setTeamOffDays() async {
//     final Map<String, int> gamesPerDay = {};
//     for (final date in gameDates) {
//       gamesPerDay[date.date] = date.numberOfGames;
//     }
//
//     /*
//      * This section of code goes through each team's game schedule to count games played on offDays.
//      * It looks at the number of games set for each date, checking if it's within offDay range (1 to 7).
//      * Then, it checks if a team has a game on that date. If they do, it increments offDay count.
//     */
//     for (final team in teamMap.values) {
//       for (final date in gamesPerDay.keys) {
//         final todayGames = gamesPerDay[date]!;
//         if (todayGames > 0 && todayGames < 8) {
//           if (team.gameDates.contains(date)) {
//             team.offDays++;
//           }
//         }
//       }
//     }
//     //calculateStreamScores();
//     //TeamManager().calculateStreamScores(teamMap);
//   }
//
//
// }