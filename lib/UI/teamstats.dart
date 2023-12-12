import 'package:flutter/material.dart';

class TeamStats extends StatefulWidget {
  const TeamStats({Key? key}) : super(key: key);

  @override
  _TeamStatsState createState() => _TeamStatsState();
}

class _TeamStatsState extends State<TeamStats> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Stats'),
      ),
    );
  }
}