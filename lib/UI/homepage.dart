import 'package:flutter/material.dart';
import '../managers/game_manager.dart';
import '../model/games.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GameManager scheduleView = GameManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NHL Games'),
      ),
      body: FutureBuilder(
        future: scheduleView.fetchGameData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              // If data is loading, display a 'loading circle'
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching NHL Game data..'),
            );
          } else {
            return buildGameList(scheduleView.gameDates, scheduleView.teamMap);
          }
        },
      ),
    );
  }

  Widget buildGameList(List<GameDate> gameDates, Map<String, Team> teamMap) {
    return ListView.builder(
      itemCount: gameDates.length + 1, // Add 1 for streamer scores
      itemBuilder: (context, index) {
        if (index == gameDates.length) {
          // This will display the streamer scores
          final sortedTeams = teamMap.values.toList()
              ..sort((a, b) => b.streamerScore.compareTo(a.streamerScore));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Streamer Scores:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedTeams.length,
                itemBuilder: (context, idx) {
                  final Team team = sortedTeams[idx];
                  return ListTile(
                    title: Text('${team.teamName}: This Week Streamer Score - ${team.streamerScore.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.white,
                      ),
                    ),
                    subtitle: Text('Total Games Played: ${team.totalGames}\nTotal Off Days: ${team.offDays}',
                    style: TextStyle(
                      color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        } else {
          final GameDate gameDay = gameDates[index];
          return ExpansionTile(
            title: ListTile(
              title: Text('Date: ${gameDay.date}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                ),
              ),
              subtitle: Text('Number of games: ${gameDay.numberOfGames}',
              style: TextStyle(
                color: Colors.white,
                ),
              ),
            ),
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gameDay.gameList.length,
                itemBuilder: (context, idx) {
                  final Game game = gameDay.gameList[idx];
                  return ListTile(
                    title: Text('${game.awayTeam} @ ${game.homeTeam}',
                    style: TextStyle(
                      color: Colors.white,
                      ),
                    ),
                    subtitle: Text('Date: ${game.date}',
                    style: TextStyle(
                      color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}