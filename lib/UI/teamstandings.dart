import 'package:flutter/material.dart';

class TeamStandings extends StatefulWidget {
  const TeamStandings({Key? key}) : super(key: key);

  @override
  _TeamStandingsState createState() => _TeamStandingsState();
}

class _TeamStandingsState extends State<TeamStandings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Standings'),
      ),
    );
  }
}