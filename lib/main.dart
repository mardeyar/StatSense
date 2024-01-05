import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nhl/managers/function_manager.dart';
import '../UI/schedule.dart';
import '../UI/streamerscores.dart';
import '../UI/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FunctionManager().writeData();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
    runApp(MyApp());
  });
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
    Settings(),
  ];

  // Sets the initial index on bottom nav to 0; 'HomePage'
  int _selectedNavIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the "debug" corner label
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF293034)),
      home: Scaffold(
        body: appPages[_selectedNavIndex], // Will show the selected nav page
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Streamer Scores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
          currentIndex: _selectedNavIndex,
          selectedItemColor: Color(0xFF0486BD),
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