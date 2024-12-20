import 'package:flutter/material.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  // Light theme color scheme (Facebook Style)
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1877F2), // Facebook Blue
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF42A5F5), // Lighter Blue for container
      onPrimaryContainer: Colors.black,
      secondary: Color(0xFF42A5F5), // Lighter Blue for secondary
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFFBBDEFB), // Soft blue for container
      onSecondaryContainer: Colors.black,
      error: Color(0xFFF44336), // Red for errors
      onError: Colors.white,
      errorContainer: Color(0xFFEF9A9A), // Light red container
      onErrorContainer: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceContainerHighest: Colors.grey,
      outline: Colors.black,
      shadow: Colors.black,
      scrim: Colors.black,
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  // Dark theme color scheme (Facebook Style)
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF42A5F5), // Lighter Blue for dark mode primary
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF1877F2), // Darker blue for container
      onPrimaryContainer: Colors.white,
      secondary: Color(0xFF42A5F5), // Lighter Blue for secondary
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFFBBDEFB), // Soft blue container
      onSecondaryContainer: Colors.black,
      error: Color(0xFFF44336), // Red for errors
      onError: Colors.white,
      errorContainer: Color(0xFFEF9A9A), // Light red container
      onErrorContainer: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceContainerHighest: Colors.grey,
      outline: Colors.white,
      shadow: Colors.black,
      scrim: Colors.black,
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  // Helper method to generate ThemeData based on ColorScheme
  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor: colorScheme.surface,
      canvasColor: colorScheme.surface,
    );
  }
}
