import 'package:flutter/material.dart';
import 'package:nhl/managers/team_manager.dart';
import '../managers/game_manager.dart';
import '../model/games.dart';
import '../model/team.dart';

class StreamerScore extends StatefulWidget {
  const StreamerScore({Key? key}) : super(key: key);

  @override
  _StreamerScoreState createState() => _StreamerScoreState();
}

class _StreamerScoreState extends State<StreamerScore> {
  final GameManager streamerView = GameManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streamer Scores'),
      ),
      body: FutureBuilder(
        future: streamerView.fetchGameData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error: Could not fetch streamer score data...'),
            );
          } else {
            return buildStreamerScores(streamerView.teamMap);
          }
        },
      ),
    );
  }

  Widget buildStreamerScores(Map<String, Team> teamMap) {
    final teamsByScore = teamMap.values.toList()
        ..sort((a, b) => b.streamerScore.compareTo(a.streamerScore));

    return ListView.builder(
      itemCount: teamsByScore.length,
      itemBuilder: (context, index) {
        final Team team = teamsByScore[index];
        return ListTile(
          title: Text(
            '${team.teamName}: This Week Streamer Score - ${team.streamerScore.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Total Games Player: ${team.totalGames}\nTotal Off Days: ${team.offDays}',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}