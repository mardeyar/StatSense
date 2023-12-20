import 'package:flutter/material.dart';

class AppBarStyle {
  static const TextStyle appBarText = TextStyle(
    fontFamily: 'Rowdies-Regular',
    fontSize: 32,
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
  );

  static const TextStyle selectedDayText = TextStyle(
    fontFamily: 'Inter-Bold',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 18,
  );

  static ButtonStyle dayButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(0)),
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
