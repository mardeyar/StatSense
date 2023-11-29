import 'package:flutter/material.dart';
import '../UI/homepage.dart';
import '../UI/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the "debug" corner label
      initialRoute: '/',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(606060)),
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}