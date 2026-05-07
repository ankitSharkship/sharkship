import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sharkship/shared/constants/app_color_extension.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/constants/app_text_styles.dart';
import 'routes/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData(
        useMaterial3: true,
        textTheme: AppTextTheme.textTheme,
        colorScheme: AppColors.colorScheme,
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        extensions: [
          const AppColorExtension(
            lightBlueBg: Color(0xFFE1EEF4),
            lightGreen: Color(0xFFE1FEEC),
            scaffoldBg: Color(0xFFF5F5F5),
            loginGradientStart: AppColors.loginGradientStart,
            loginGradientEnd: AppColors.loginGradientEnd,
            primaryGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF184FA2), Color(0xFF27AAE2), Color(0xFF91D3EE)],
            ),
          ),
        ],
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}
