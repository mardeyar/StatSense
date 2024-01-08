import 'package:flutter/material.dart';
import 'package:statsense/utils/styles.dart';
import '../managers/function_manager.dart';
import '../model/team.dart';

class TeamDetails extends StatelessWidget {
  final Team team;
  final FunctionManager appFunction = FunctionManager();

  TeamDetails({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 8),
            Text(
              'Team Details',
              style: AppBarStyle.appBarText,
            ),
          ],
        ),
        backgroundColor: AppBarStyle.appBarBackground,
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          team.getLogoURL(),
                          height: 40,
                          width: 40,
                        ),
                      ),
                      Text(
                        '${team.teamName}',
                        style: BodyTextStyle.bodyTextStyleBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Last 10 Games Trend Report',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 5),
            Text(
              'Record: ${team.last10Wins}-${team.last10Losses}-${team.last10OTL}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'Points: ${team.last10Points}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'GF Average: ${team.last10GoalsFor / 10}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'GA Average: ${team.last10GoalsAgainst / 10}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'Streak: ${team.streakCount}${team.streakCode}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            SizedBox(height: 8),
            Text(
              'Season Stats',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 5),
            Text(
              'Games Played: ${team.gamesPlayed}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'Record: ${team.totalWins}-${team.totalLosses}-${team.totalOTL}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'Points: ${(team.totalWins * 2) + (team.totalOTL)}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'GF Average: ${(team.goalsFor / team.gamesPlayed).toStringAsFixed(2)}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            Text(
              'GA Average: ${(team.goalsAgainst / team.gamesPlayed).toStringAsFixed(2)}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
            SizedBox(height: 8),
            Text(
              'Summary',
              style: BodyTextStyle.bodyTextStyleBold,
            ),
            SizedBox(height: 5),
            Text(
              '${appFunction.getTrendingAnalysis(team)}',
              style: BodyTextStyle.bodyTextStyleReg,
            ),
          ],
        ),
      ),
    );
  }
}