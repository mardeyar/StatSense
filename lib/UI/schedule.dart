import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../managers/function_manager.dart';
import '../model/games.dart';
import '../utils/styles.dart';
import '../model/team.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final FunctionManager appFunction = FunctionManager();
  late int _selectedDayIndex;

  @override
  void initState() {
    super.initState();
    _selectedDayIndex = DateTime.now().weekday - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NHL Schedule',
        style: AppBarStyle.appBarText,
        ),
        backgroundColor: AppBarStyle.appBarBackground,
      ),
      body: Column(
        children: [
          _buildDaySelectRow(),
          Expanded(
            child: FutureBuilder(
              future: appFunction.readData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error: could not fetch NHL Game data...'),
                  );
                } else {
                  // Filter games based on the selected day
                  final List<GameDate> filteredGameDates = appFunction.gameDates
                      .where((gameDate) =>
                  DateTime.parse(gameDate.date).weekday == _selectedDayIndex + 1)
                      .toList();
                  return buildGameList(filteredGameDates);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDaySelectRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (index) {
          final day = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).add(Duration(days: index));
          return Padding(
            padding: EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedDayIndex = index;
                });
              },
              style: DayButtonStyle.dayButtonStyle,
              child: Text(
                DateFormat.E().format(day),
                style: _selectedDayIndex == index
                  ? DayButtonStyle.selectedDayText
                  : DayButtonStyle.dayButtonText,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildGameList(List<GameDate> gameDates) {
    return ListView.builder(
      itemCount: gameDates.length,
      itemBuilder: (context, index) {
        final GameDate gameDay = gameDates[index];
        final formattedDate = _formatDate(gameDay.date);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Center(
                child: Text(
                  '$formattedDate\n${gameDay.numberOfGames} games on tonight',
                  style: BodyTextStyle.bodyTextStyleBold,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: gameDay.gameList.map((game) {
                  final formattedTime = _formatTime(game.date);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF282828), Color(0xFF2A2A2A)],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Image.asset(
                                      Team(teamAbbrev: game.awayTeam).getLogoURL(),
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        game.awayTeam,
                                        style: BodyTextStyle.bodyTextStyleBold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    'vs',
                                    style: BodyTextStyle.bodyTextStyleBold,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        game.homeTeam,
                                        style: BodyTextStyle.bodyTextStyleBold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Image.asset(
                                      Team(teamAbbrev: game.homeTeam).getLogoURL(),
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                '$formattedTime',
                                style: BodyTextStyle.bodyTextStyleReg,
                              ),
                            ],
                          ),
                        ),

                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }


  String _formatTime(String utcDate) {
    final dateTime = DateTime.parse(utcDate).toLocal();
    final timeFormat = DateFormat('hh:mm a').format(dateTime);
    return timeFormat;
  }

  String _formatDate(String utcDate) {
    final newDate = DateTime.parse(utcDate).toLocal();
    final dateFormat = DateFormat("MMM d, y").format(newDate);
    return dateFormat;
  }
}
