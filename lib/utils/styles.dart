import 'package:flutter/material.dart';

class AppBarStyle {
  static const TextStyle appBarText = TextStyle(
    fontFamily: 'Inter-Bold',
    fontSize: 28,
    color: Colors.white,
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    elevation: 4,
    shadowColor: Colors.black,
  );

  static const Color appBarBackground = Color.fromRGBO(78, 128, 152, 100);
}

class DayButtonStyle {
  // Styles for the schedule date buttons
  static const TextStyle dayButtonText = TextStyle(
    fontFamily: 'Inter-Regular',
    color: Colors.white60,
    fontSize: 10,
  );

  static const TextStyle selectedDayText = TextStyle(
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 12,
  );

  static ButtonStyle dayButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
  );
}

class BodyTextStyle {
  static const TextStyle bodyTextStyleBold = TextStyle(
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.white,
  );

  static const TextStyle bodyTextStyleReg = TextStyle(
    fontFamily: 'Inter-Regular',
    color: Colors.white,
  );
}
