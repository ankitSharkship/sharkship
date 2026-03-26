import 'package:go_router/go_router.dart';
import 'package:sharkship/features/kyc/presentation/screens/kyc_screen.dart';
import 'package:sharkship/features/login/presentation/views/get_started.dart';
import 'package:sharkship/features/auth/presentation/screens/login_screen.dart';
import 'package:sharkship/features/nav/presentation/screens/main_screen.dart';
import 'package:sharkship/splash.dart';
part 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: Routes.SPLASH,
  routes: [
    GoRoute(
      path: Routes.SPLASH,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.GET_STARTED,
      builder: (context, state) => const GetStartedScreen(),
    ),
    GoRoute(
      path: Routes.SIGNIN,
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(path: Routes.HOME, builder: (context, state) => const MainScreen()),
    GoRoute(path: Routes.KYC, builder: (context, state) => const KycScreen()),
  ],
);
