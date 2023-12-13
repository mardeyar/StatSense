import 'package:flutter/material.dart';
import '../UI/homepage.dart';
import '../UI/teamstats.dart';
import '../UI/schedule.dart';

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
    const HomePage(),
    const Schedule(),
    const TeamStats(),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_hockey),
              label: 'Games',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'Team Stats',
            )
          ],
          currentIndex: _selectedNavIndex,
          selectedItemColor: Color(0xFF202020),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}