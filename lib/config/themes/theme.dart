import 'package:flutter/material.dart';

ThemeData get lightTheme {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1F662E), 
      primaryContainer: Color(0xFF1F662E),
      secondary: Color(0xFF4CAF50), 
      surface: Colors.white,
      onPrimary: Colors.white,
      onSurface: Colors.black,
      error: Colors.red,
      brightness: Brightness.light,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F662E),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Text fields styling
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1F662E)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1F662E), width: 2),
      ),
      labelStyle: const TextStyle(color: Color(0xFF1F662E)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1F662E), 
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1F662E),
        textStyle: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
    ),

    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle( 
        fontSize: 16,
        color: Colors.black,
      ),
      labelLarge: TextStyle( 
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // Social buttons section
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF1F662E),
        side: const BorderSide(color: Color(0xFF1F662E)),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}
