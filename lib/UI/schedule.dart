import 'package:flutter/material.dart';
import '../managers/standings_manager.dart';
import '../managers/game_manager.dart';
import '../model/games.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final GameManager weeklySchedule = GameManager();
  final List<GameDate> weeklyGames;
  final Map<String, Team> listOfTeams;

  SchedulePage({required this.weeklyGames, required this.listOfTeams});

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
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weeklyGames.length,
              itemBuilder: (context, index) {
                final GameDate gameDay = weeklyGames[index];
                return InkWell(
                  onTap: () {
                    // Handle day selection
                  },
                  child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      '${gameDay.date}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          // Vertical listview for games
          Expanded(
            child: ListView.builder(
              itemCount: weeklyGames.length > 0
                  ? weeklyGames[0].gameList[index];

            ),
          )
        ],
      ),
    )
  }
}