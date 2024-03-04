import 'package:flutter/material.dart';
import 'package:pokedex/core/presentation/theme/colors.dart';

class UITheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: UIColors.primaryColor,
      primaryColorDark: UIColors.primaryColorDark,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 40.0,
          fontWeight: FontWeight.bold,
          color: UIColors.primaryTextColor,
        ),
        titleMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: UIColors.primaryTextColor,
        ),
        titleSmall: TextStyle(
          fontSize: 16.0,
          color: UIColors.secondaryTextColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 20.0,
          color: UIColors.primaryTextColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 16.0,
          color: UIColors.primaryTextColor,
        ),
        bodySmall: TextStyle(
          fontSize: 14.0,
          color: UIColors.primaryTextColor,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: UIColors.primaryColor,
        secondary: UIColors.accentColor,
        background: UIColors.backgroundColor,
        onError: UIColors.error,
      ),
    );
  }
}
