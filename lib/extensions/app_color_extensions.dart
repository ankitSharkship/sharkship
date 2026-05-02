import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_color_extension.dart';


extension AppThemeX on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;

  AppColorExtension get extraColors =>
      Theme.of(this).extension<AppColorExtension>()!;
}