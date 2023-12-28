import 'package:flutter/material.dart';
import 'package:nhl/utils/styles.dart';
import '../managers/function_manager.dart';
import '../model/team.dart';

class StreamerScore extends StatefulWidget {
  const StreamerScore({Key? key}) : super(key: key);

  @override
  _StreamerScoreState createState() => _StreamerScoreState();
}

class _StreamerScoreState extends State<StreamerScore> {
  final FunctionManager appFunction = FunctionManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Streamer Scores',
        style: AppBarStyle.appBarText,
        ),
        backgroundColor: AppBarStyle.appBarBackground,
      ),
      body: FutureBuilder(
        future: appFunction.fetchGameData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error: Could not fetch streamer score data...'),
            );
          } else {
            return buildStreamerScores(appFunction.teamMap);
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

        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF282828), Color(0xFF2A2A2A)],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                title: Text(
                  '${team.teamName}: ${team.streamerScore.toStringAsFixed(2)}',
                  style: BodyTextStyle.bodyTextStyleBold,
                ),
                subtitle: Text(
                  'Games: ${team.totalGames}\nOff Days: ${team.offDays}',
                  style: BodyTextStyle.bodyTextStyleReg,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}