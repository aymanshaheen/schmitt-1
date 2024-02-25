import 'package:flutter/material.dart';

ThemeData getThemeDataDark() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[900],
    scaffoldBackgroundColor: Colors.blueGrey[900],
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.blueGrey[800],
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8.0),
      ),
      hintStyle: TextStyle(
        color: Colors.grey[400],
      ),
    ),
    // Define button styles
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    // Define other properties of the dark theme
    // You can customize these according to your app's design
  );
}
