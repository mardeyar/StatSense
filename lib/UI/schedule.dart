import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../managers/game_manager.dart';
import '../model/games.dart';
import '../utils/styles.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final GameManager scheduleView = GameManager();
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
              future: scheduleView.fetchGameData(),
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
                  final List<GameDate> filteredGameDates = scheduleView.gameDates
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
            padding: EdgeInsets.symmetric(vertical: 8.0),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Center( // Wrapping with Center widget to center the date
                child: Text(
                  '$formattedDate | ${gameDay.numberOfGames} games on tonight',
                  style: BodyTextStyle.bodyTextStyleBold,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: gameDay.gameList.map((game) {
                final formattedTime = _formatTime(game.date);
                return ListTile(
                  title: Text(
                    '${game.awayTeam} @ ${game.homeTeam}',
                    style: BodyTextStyle.bodyTextStyleReg,
                  ),
                  subtitle: Text(
                    '$formattedTime',
                    style: BodyTextStyle.bodyTextStyleReg,
                  ),
                );
              }).toList(),
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
