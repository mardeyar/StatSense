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

  static const Color appBarBackground = Color(0xFF3f3f3f);
}

class DayButtonStyle {
  // Styles for the schedule date buttons
  static const TextStyle dayButtonText = TextStyle(
    fontFamily: 'Lato-Regular',
    color: Color(0xFF8b8b8b),
    fontSize: 11,
  );

  static const TextStyle selectedDayText = TextStyle(
    fontFamily: 'Lato-Bold',
    fontWeight: FontWeight.bold,
    color: Color(0xFFDCDCDC),
    fontSize: 13,
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
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF7575757), Color(0xcb575757)],
    ),
  );
}

class BottomNavStyle {
  static Color bottomNavColor = Color(0xFF3f3f3f);
}