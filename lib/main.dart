import 'package:flutter/material.dart';
import '../UI/teamstandings.dart';
import '../UI/schedule.dart';
import '../UI/streamerscores.dart';
import '../UI/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This section will define all the pages used by the app, shown on bottom nav
  final List<Widget> appPages = [
    const Schedule(),
    const StreamerScore(),
    const TeamStandings(),
    Settings(),
  ];

  // Sets the initial index on bottom nav to 0; 'HomePage'
  int _selectedNavIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the "debug" corner label
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF1E1E1E)),
      home: Scaffold(
        body: appPages[_selectedNavIndex], // Will show the selected nav page
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_hockey),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.score),
              label: 'Streamer Scores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.query_stats),
              label: 'Team Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
          currentIndex: _selectedNavIndex,
          selectedItemColor: Color(0xFF3FC3F5),
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 8,
          ),
          selectedLabelStyle: TextStyle(
            color: Colors.black,
            fontSize: 8,
          ),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}