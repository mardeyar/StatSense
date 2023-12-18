import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/players.dart';

class PlayerManager {
  // Need to determine a way of rating the players for fantasy stats
  Future<List<Player>> fetchTopPlayers(List<int> playerIDs) async {
    List<Player> topPlayers = [];
    for (int i = 0; i < playerIDs.length; i++) {
      Player player = await fetchPlayerStats(playerIDs[i]);
      topPlayers.add(player);
    }
    return calculateTopPlayers(topPlayers);
  }

  List<Player> calculateTopPlayers(List<Player> players) {
    players.sort((playerA, playerB) {
      double ptsPlayerA = calculatePerformance(playerA);
      double ptsPlayerB = calculatePerformance(playerB);
      return ptsPlayerB.compareTo(ptsPlayerA);
    });

    return players.sublist(0, players.length < 5 ? players.length : 5);
  }

  double calculatePerformance(Player player) {
    double playerRating = 0.0;

    // Assign values to each scoring category
    playerRating += player.last5Goals * 2;
    playerRating += player.last5Assists;
    playerRating += player.last5PlusMinus;
    playerRating += player.last5PPG * 0.75;
    playerRating += player.last5Shots * 0.5;
    playerRating += player.last5PIM;

    return playerRating;
  }

  Future<Player> fetchPlayerStats(int playerID) async {
    final playerStatResponse = await http.get(
      Uri.parse('https://api-web.nhle.com/v1/player/$playerID/landing'),
    );

    if (playerStatResponse.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(playerStatResponse.body);
      final List<dynamic> last5Games = responseData['last5Games'];

      // Need to initialize variables to 0 for a players last 5
      double last5Goals = 0;
      double last5Assists = 0;
      double last5Pts = 0;
      double last5PlusMinus = 0;
      double last5PPG = 0;
      double last5Shots = 0;
      double last5PIM = 0;

      // Run calculation to get totals for last 5 GP
      for (final game in last5Games) {
        last5Goals += game['goals'];
        last5Assists += game['assists'];
        last5Pts += game['points'];
        last5PlusMinus += game['plusMinus'];
        last5PPG += game['powerPlayGoals'];
        last5Shots += game['shots'];
        last5PIM += game['pim'];
      }

      return Player(
          playerID: responseData['playerId'],
          firstName: responseData['firstName']['default'],
          lastName: responseData['lastName']['default'],
          last5Goals: last5Goals,
          last5Assists: last5Assists,
          last5Pts: last5Pts,
          last5PlusMinus: last5PlusMinus,
          last5PPG: last5PPG,
          last5Shots: last5Shots,
          last5PIM: last5PIM,
      );
    } else {
      throw Exception('Failed to load player data...');
    }
  }
}