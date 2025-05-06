import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme(BuildContext context) => ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF0066CC),
    brightness: Brightness.light,
    primary: Color(0xFF0066CC),
    secondary: Color(0xFF26292D),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    Theme.of(context).textTheme.copyWith(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Color(0xFF0066CC)),
      titleMedium: TextStyle(color: Color(0xFF0066CC)),
      headlineLarge: TextStyle(color: Color(0xFF0066CC)),
      headlineMedium: TextStyle(color: Color(0xFF0066CC)),
      labelLarge: TextStyle(color: Color(0xFF0066CC)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF0066CC),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xFF0066CC)),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF0066CC),
      side: BorderSide(color: Color(0xFF0066CC)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF0066CC)),
    ),
    hintStyle: TextStyle(color: Colors.grey),
  ),
  dividerColor: Colors.grey,
  hintColor: Colors.grey,
  focusColor: Color(0xFF0066CC),
  splashColor: Color(0xFF0066CC),
  snackBarTheme: SnackBarThemeData(backgroundColor: Colors.black),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
);

ThemeData darkTheme(BuildContext context) => ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF0066CC),
    brightness: Brightness.dark,
    primary: Color(0xFF0066CC),
    secondary: Color(0xFF26292D),
  ),
  textTheme: GoogleFonts.poppinsTextTheme(
    Theme.of(context).textTheme.copyWith(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Color(0xFF0066CC)),
      titleMedium: TextStyle(color: Color(0xFF0066CC)),
      headlineLarge: TextStyle(color: Color(0xFF0066CC)),
      headlineMedium: TextStyle(color: Color(0xFF0066CC)),
      labelLarge: TextStyle(color: Color(0xFF0066CC)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Color(0xFF0066CC)),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF0066CC),
      side: BorderSide(color: Color(0xFF0066CC)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color(0xFF0066CC)),
    ),
    hintStyle: TextStyle(color: Colors.grey),
  ),
  dividerColor: Colors.grey,
  hintColor: Colors.grey,
  focusColor: Color(0xFF0066CC),
  splashColor: Color(0xFF0066CC),
  snackBarTheme: SnackBarThemeData(backgroundColor: Colors.grey[900]),
  bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black),
);
