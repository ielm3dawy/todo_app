import 'package:flutter/material.dart';

class ApplicationThemeManager {
  static const Color primaryColor = Color(0xFF3598DB);

  static final ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFDFECDB),
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      toolbarHeight: 140,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      unselectedIconTheme: IconThemeData(
        size: 28.0,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      displayLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      displaySmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ),
  );

  static final ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: const Color(0xFF121212),
    // لون الخلفية في الوضع الداكن
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      toolbarHeight: 140,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontFamily: "Poppins",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      unselectedIconTheme: IconThemeData(
        size: 28.0,
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      displayLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontFamily: "Poppins",
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  );
}
