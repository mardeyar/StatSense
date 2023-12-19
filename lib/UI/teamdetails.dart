import 'package:flutter/material.dart';
import 'package:nhl/managers/standings_manager.dart';
import '../model/players.dart';
import '../model/standings.dart';

class TeamDetails extends StatelessWidget {
  final Team team;

  const TeamDetails({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final standingsManager = StandingsManager();
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
            Text('Home Record: ${team.homeWins} - ${team.homeLosses} - ${team.homeOTL}', style: TextStyle(color: Colors.white)),
            Text('Away Record: ${team.roadWins} - ${team.roadLosses} - ${team.roadOTL}', style: TextStyle(color: Colors.white)),
            Text('Last 10 Record: ${team.last10Wins} - ${team.last10Losses} - ${team.last10OTL}', style: TextStyle(color: Colors.white)),
            Text('Goals For: ${team.goalsFor}', style: TextStyle(color: Colors.white)),
            Text('Goals Against: ${team.goalsAgainst}', style: TextStyle(color: Colors.white)),
            Text('Streak: ${team.streakCount}${team.streakCode}', style: TextStyle(color: Colors.white)),
            Text('${team.teamAbbrev} Trending Players Last 5 Games', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            FutureBuilder<List<Player>>(
              future: standingsManager.fetchTopPlayers(team),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error.toString()}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
                } else if (snapshot.hasData) {
                  final topPlayers = snapshot.data!;
                  return Column(
                    children: topPlayers.map((player) {
                      return ListTile(
                        title: Text('${player.firstName} ${player.lastName}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        subtitle: Text('Goals: ${player.last5Goals}\n'
                            'Assists: ${player.last5Assists}\n'
                            '+/-:  ${player.last5PlusMinus}\n'
                            'PPG: ${player.last5PPG}\n'
                            'SOG: ${player.last5Shots}\n'
                            'PIM: ${player.last5PIM}', style: TextStyle(color: Colors.white)
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Text('No data available.', style: TextStyle(color: Colors.white));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}