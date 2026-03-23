import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:sharkship/features/login/presentation/views/login_screen.dart';
import 'package:sharkship/splash.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Placeholder(),
    ),
  ],
);
