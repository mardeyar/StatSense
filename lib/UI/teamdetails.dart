import 'package:flutter/material.dart';
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
            Image.asset(
              team.getLogoURL(),
              height: 40,
              width: 40,
            ),
            SizedBox(width: 8),
            Text(team.teamName),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Conference: ${team.conference}', style: TextStyle(color: Colors.white)),
            Text('Division: ${team.division}', style: TextStyle(color: Colors.white)),
            Text('Season Record: ${team.totalWins} - ${team.totalLosses} - ${team.totalOTL}', style: TextStyle(color: Colors.white)),
            Text('Last 10 Record: ${team.last10Wins} - ${team.last10Losses} - ${team.last10OTL}', style: TextStyle(color: Colors.white)),
            Text('Goals For: ${team.goalsFor}', style: TextStyle(color: Colors.white)),
            Text('Goals Against: ${team.goalsAgainst}', style: TextStyle(color: Colors.white)),
            Text('Streak: ${team.streakCount}${team.streakCode}', style: TextStyle(color: Colors.white)),
            Text('Points: ${team.last10Points}', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}