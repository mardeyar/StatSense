import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/players.dart';
import '../managers/team_manager.dart';
import '../model/team.dart';

class PlayerManager {
  TeamManager teamManager;
  PlayerManager(this.teamManager);

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
      teamManager.playerList.add(player);

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