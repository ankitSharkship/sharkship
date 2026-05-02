import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primaryBlue = Color(0xFF184FA2);
  static const Color secondaryBlue = Color(0xFF27AAE2);
  static const Color lightBlue = Color(0xFF91D3EE);

  static const Color lightBlueBg = Color(0xFFE1EEF4);
  static const Color lightGreen = Color(0xFFE1FEEC);

  static const Color loginGradientStart = Color(0xFF1E88C8);
  static const Color loginGradientEnd = Color(0xFF6EC1E4);

  static const Color scaffoldBg = Color(0xFFF5F5F5);

  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,

    primary: primaryBlue,
    onPrimary: Colors.white,

    secondary: secondaryBlue,
    onSecondary: Colors.white,

    surface: Colors.white,
    onSurface: Colors.black,

    error: Colors.red,
    onError: Colors.white,

    // required but often ignored
    primaryContainer: lightBlue,
    onPrimaryContainer: Colors.black,

    secondaryContainer: lightBlueBg,
    onSecondaryContainer: Colors.black,

    outline: Colors.grey,
    shadow: Colors.black,
    inverseSurface: Colors.black,
    onInverseSurface: Colors.white,
    inversePrimary: secondaryBlue,
    surfaceTint: primaryBlue,
  );
}