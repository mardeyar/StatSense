import 'package:flutter/material.dart';

class AppBarStyle {
  static const TextStyle appBarText = TextStyle(
    fontFamily: 'Lato-Bold',
    fontSize: 28,
    color: Colors.white,
  );

  static AppBarTheme appBarTheme = AppBarTheme(
    elevation: 4,
    shadowColor: Colors.black,
  );

  static const Color appBarBackground = Color(0xFF1A2123);
}

class DayButtonStyle {
  // Styles for the schedule date buttons
  static const TextStyle dayButtonText = TextStyle(
    fontFamily: 'Lato-Regular',
    color: Colors.white60,
    fontSize: 12,
  );

  static const TextStyle selectedDayText = TextStyle(
    fontFamily: 'Lato-Bold',
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 14,
  );

  static ButtonStyle dayButtonStyle = ButtonStyle(
    elevation: MaterialStateProperty.all<double>(0),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
  );
}

class BodyTextStyle {
  static const TextStyle bodyTextStyleBold = TextStyle(
    fontFamily: 'Lato-Bold',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.white,
  );

  static const TextStyle bodyTextStyleReg = TextStyle(
    fontFamily: 'Lato-Regular',
    color: Colors.white,
  );
}

class CardStyle {
  static Decoration cardBackground = BoxDecoration(
    borderRadius: BorderRadius.circular(5.0),
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color(0xFF2F3A3F), Color(0xBE2F3A3F)],
    ),
  );
}
