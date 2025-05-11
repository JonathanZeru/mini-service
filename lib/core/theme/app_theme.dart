import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Primary color - Green
  static const Color primaryColor = Color(0xFF2E7D32); // Green 800
  static const Color primaryLightColor = Color(0xFF60AD5E); // Green 600
  static const Color primaryDarkColor = Color(0xFF005005); // Green 900
  
  // Secondary color
  static const Color secondaryColor = Color(0xFF00796B); // Teal 700
  static const Color secondaryLightColor = Color(0xFF48A999); // Teal 500
  static const Color secondaryDarkColor = Color(0xFF004C40); // Teal 900
  
  // Background colors
  static const Color lightBackgroundColor = Color(0xFFF5F5F5);
  static const Color darkBackgroundColor = Color(0xFF121212);
  
  // Surface colors
  static const Color lightSurfaceColor = Colors.white;
  static const Color darkSurfaceColor = Color(0xFF1E1E1E);
  
  // Error colors
  static const Color errorColor = Color(0xFFB00020);
  static const Color darkErrorColor = Color(0xFFCF6679);
  
  // Text colors
  static const Color lightTextColor = Color(0xFF212121);
  static const Color lightSecondaryTextColor = Color(0xFF757575);
  static const Color darkTextColor = Color(0xFFEEEEEE);
  static const Color darkSecondaryTextColor = Color(0xFFAAAAAA);

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins', // Set Poppins as the default font family
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      primaryContainer: primaryLightColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      secondaryContainer: secondaryLightColor,
      onSecondary: Colors.white,
      error: errorColor,
      background: lightBackgroundColor,
      surface: lightSurfaceColor,
      onBackground: lightTextColor,
      onSurface: lightTextColor,
    ),
    scaffoldBackgroundColor: lightBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      // Set Poppins for AppBar title
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: lightSurfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: errorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      // Set Poppins for input labels and hints
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: lightSecondaryTextColor,
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: lightSecondaryTextColor,
      ),
      errorStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: errorColor,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.grey[200],
      selectedColor: primaryLightColor,
      disabledColor: Colors.grey[300],
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: lightSurfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: lightSecondaryTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      // Set Poppins for bottom navigation labels
      selectedLabelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
      space: 1,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        color: lightSecondaryTextColor,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        color: lightTextColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins', // Set Poppins as the default font family
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      primaryContainer: primaryDarkColor,
      onPrimary: Colors.white,
      secondary: secondaryColor,
      secondaryContainer: secondaryDarkColor,
      onSecondary: Colors.white,
      error: darkErrorColor,
      background: darkBackgroundColor,
      surface: darkSurfaceColor,
      onBackground: darkTextColor,
      onSurface: darkTextColor,
    ),
    scaffoldBackgroundColor: darkBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkSurfaceColor,
      foregroundColor: darkTextColor,
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      // Set Poppins for AppBar title
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: darkTextColor,
      ),
    ),
    cardTheme: CardTheme(
      color: darkSurfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        textStyle: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF555555)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF555555)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: darkErrorColor),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      // Set Poppins for input labels and hints
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: darkSecondaryTextColor,
      ),
      hintStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: darkSecondaryTextColor,
      ),
      errorStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: darkErrorColor,
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFF2C2C2C),
      selectedColor: primaryColor,
      disabledColor: const Color(0xFF3C3C3C),
      labelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
      ),
      secondaryLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: darkSurfaceColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: darkSecondaryTextColor,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
      // Set Poppins for bottom navigation labels
      selectedLabelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 12,
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF3C3C3C),
      thickness: 1,
      space: 1,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        color: darkSecondaryTextColor,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        color: darkTextColor,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static void updateSystemUIOverlayStyle(ThemeMode mode) {
    final isDark = mode == ThemeMode.dark || 
        (mode == ThemeMode.system && WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: isDark ? darkSurfaceColor : lightSurfaceColor,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
