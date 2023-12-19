import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/standings.dart';
import '../model/players.dart';

class StandingsManager {
  List<Team> teamList = [];
  List<Player> playerList = [];

  Future<void> fetchTeams() async {

    // Fetch the teams data from the NHL API
    final teamResponse = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/standings/now'),
    );

    if (teamResponse.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(teamResponse.body);
      final List<dynamic> allTeams = responseData['standings'];

      // Process the data from the team retrieval API call
      teamList = await Future.wait(
          allTeams.map((teamData) async {
            var team = Team(
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
              last10Points: teamData['l10Points'],
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
            );

            await team.fetchRoster();

            return team;
          }),
      );
    } else {
      throw Exception('Failed to load NHL teams data...');
    }
  }
  
  // This method will make API calls to the endpoint and fetch player details
  Future<Player> fetchPlayerDetails(int playerId) async {
    final playerResponse = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/player/$playerId/landing')
    );

    if (playerResponse.statusCode == 200) {
      final Map<String, dynamic> playerData = json.decode(playerResponse.body);

      // Extract the players last 5 game totals, initialize to 0
      List<dynamic> last5Games = playerData['last5Games'];
      num last5Goals = 0;
      num last5Assists = 0;
      num last5Pts = 0;
      num last5PlusMinus = 0;
      num last5PPG = 0;
      num last5Shots = 0;
      num last5PIM = 0;

      for (var game in last5Games) {
        last5Goals += game['goals'];
        last5Assists += game['assists'];
        last5Pts += game['points'];
        last5PlusMinus += game['plusMinus'];
        last5PPG += game['powerPlayGoals'];
        last5Shots += game['shots'];
        last5PIM += game['pim'];
      }

      // Create a player object with that data
      Player player = Player(
        playerID: playerData['playerId'],
        firstName: playerData['firstName']['default'],
        lastName: playerData['lastName']['default'],
        last5Goals: last5Goals,
        last5Assists: last5Assists,
        last5Pts: last5Pts,
        last5PlusMinus: last5PlusMinus,
        last5PPG: last5PPG,
        last5Shots: last5Shots,
        last5PIM: last5PIM,
      );

      // Add the newly created player to playerList
      playerList.add(player);

      // Calculate the top 5 performers on each team
      player.performanceScore = calculatePerformanceScore(player);

      return player;
    } else {
      throw Exception('Error: failed to load player data...');
    }
  }

  // Fetches the top performing players
  Future<List<Player>> fetchTopPlayers(Team team) async {
    List<Player> topPlayers = [];

    // Need to iterate through the players to fetch top performers details
    for (int playerId in team.roster) {
      try {
        Player player = await fetchPlayerDetails(playerId);
        topPlayers.add(player);
      } catch (e) {
        print('Error: $e');
      }

    }

    topPlayers.sort((playerA, playerB) => playerB.performanceScore.compareTo(playerA.performanceScore));

    return topPlayers.length > 5 ? topPlayers.sublist(0, 5) : topPlayers;
  }

  double calculatePerformanceScore(Player player) {
    // Define the weighted criteria for each player stat
    final double goalWeight = 1.8;
    final double assistWeight = 1.3;
    final double plusMinusWeight = 1;
    final double ppgWeight = 1.2;
    final double sogWeight = 0.5;
    final double pimWeight = 1;

    // Calculate the performanceScore for each player based on that
    double playerScore = (player.last5Goals * goalWeight) +
        (player.last5Assists * assistWeight) +
        (player.last5PlusMinus * plusMinusWeight) +
        (player.last5PPG * ppgWeight) +
        (player.last5Shots * sogWeight) +
        (player.last5PIM * pimWeight);

    return playerScore;
  }
}