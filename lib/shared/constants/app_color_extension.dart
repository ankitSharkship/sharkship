import 'package:flutter/material.dart';

@immutable
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color lightBlueBg;
  final Color lightGreen;
  final Color scaffoldBg;
  final Color loginGradientStart;
  final Color loginGradientEnd;
  final LinearGradient primaryGradient;

  const AppColorExtension({
    required this.lightBlueBg,
    required this.lightGreen,
    required this.scaffoldBg,
    required this.loginGradientStart,
    required this.loginGradientEnd,
    required this.primaryGradient,
  });

  @override
  AppColorExtension copyWith({
    Color? lightBlueBg,
    Color? lightGreen,
    Color? scaffoldBg,
    Color? loginGradientStart,
    Color? loginGradientEnd,
    LinearGradient? primaryGradient,
  }) {
    return AppColorExtension(
      lightBlueBg: lightBlueBg ?? this.lightBlueBg,
      lightGreen: lightGreen ?? this.lightGreen,
      scaffoldBg: scaffoldBg ?? this.scaffoldBg,
      loginGradientStart: loginGradientStart ?? this.loginGradientStart,
      loginGradientEnd: loginGradientEnd ?? this.loginGradientEnd,
      primaryGradient: primaryGradient ?? this.primaryGradient,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;

    return AppColorExtension(
      lightBlueBg: Color.lerp(lightBlueBg, other.lightBlueBg, t)!,
      lightGreen: Color.lerp(lightGreen, other.lightGreen, t)!,
      scaffoldBg: Color.lerp(scaffoldBg, other.scaffoldBg, t)!,
      loginGradientStart: Color.lerp(loginGradientStart, other.loginGradientStart, t)!,
      loginGradientEnd: Color.lerp(loginGradientEnd, other.loginGradientEnd, t)!,
      primaryGradient: primaryGradient,
    );
  }
}