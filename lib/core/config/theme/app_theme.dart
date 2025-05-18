import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.light,
      // Add your light theme customizations here
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.dark,
      // Add your dark theme customizations here
    );
  }
}
