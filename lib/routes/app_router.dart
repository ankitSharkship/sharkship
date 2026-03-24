import 'package:go_router/go_router.dart';
import 'package:sharkship/features/login/presentation/views/get_started.dart';
import 'package:sharkship/features/auth/presentation/screens/login_screen.dart';
import 'package:sharkship/features/home/presentation/screens/home_screen.dart';
import 'package:sharkship/splash.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/get-started',
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
