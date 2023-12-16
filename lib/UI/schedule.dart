import 'package:flutter/material.dart';
import '../managers/game_manager.dart';
import '../model/games.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final GameManager scheduleView = GameManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NHL Schedule'),
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
              child: Text('Error: Could not fetch NHL Game data..'),
            );
          } else {
            return buildGameList(scheduleView.gameDates);
          }
        },
      ),
    );
  }

  Widget buildGameList(List<GameDate> gameDates) {
    return ListView.builder(
      itemCount: gameDates.length,
      itemBuilder: (context, index) {
        final GameDate gameDay = gameDates[index];
        return ExpansionTile(
          title: ListTile(
            title: Text(
              'Date: ${gameDay.date}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              'Number of games: ${gameDay.numberOfGames}',
              style: TextStyle(color: Colors.white),
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
                  title: Text(
                    '${game.awayTeam} @ ${game.homeTeam}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Date: ${game.date}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
