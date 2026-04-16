import 'package:flutter/material.dart';

class ColorManager {
  // Linear Gradient colors from your screenshot
  static const Color primaryBlue = Color(0xFF184FA2); // #184FA2 (dark blue)
  static const Color secondaryBlue = Color(0xFF27AAE2); // #27AAE2 (medium blue)
  static const Color lightBlue = Color(0xFF91D3EE); // #91D3EE (light blue)
  static const Color lightBlueBg = Color(0xFFE1EEF4);
  // Common utility colors (add more as needed)
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color scaffoldBg = Color(
    0xFFF5F5F5,
  ); // light grey for backgrounds

  // Linear gradient for your UI
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryBlue, secondaryBlue, lightBlue],
  );
}
