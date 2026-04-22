import 'package:go_router/go_router.dart';
import 'package:sharkship/features/finance/presentation/screens/seller_charges.dart';
import 'package:sharkship/features/finance/presentation/screens/shipment_rate_calculator.dart';
import 'package:sharkship/features/finance/presentation/screens/transaction_summary.dart';
import 'package:sharkship/features/kyc/presentation/screens/kyc_screen.dart';
import 'package:sharkship/features/login/presentation/views/get_started.dart';
import 'package:sharkship/features/auth/presentation/screens/login_screen.dart';
import 'package:sharkship/features/nav/presentation/screens/main_screen.dart';
import 'package:sharkship/features/ndr/presentation/screens/ndr_screen.dart';
import 'package:sharkship/features/orders/presentation/screens/create_orders.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipment_tracking.dart';
import 'package:sharkship/features/shipments/presentation/screens/shipments_screen.dart';
import 'package:sharkship/features/shipments/presentation/screens/tracking_result.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/screens/weight_discrepency.dart';
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
      builder: (context, state) {
        final mode = state.extra as String? ?? "login";
        return AuthScreen(initialMode: mode);
      },
    ),
    GoRoute(path: Routes.HOME, builder: (context, state) => const MainScreen()),
    GoRoute(path: Routes.KYC, builder: (context, state) => const KycScreen()),
    GoRoute(
      path: Routes.CREATE_ORDER,
      builder: (context, state) => const CreateOrders(),
    ),
    GoRoute(
      path: Routes.SHIPMENT,
      builder: (context, state) => ShipmentsScreen(),
    ),
    GoRoute(path: Routes.NDR, builder: (context, state) => const NdrScreen()),
    GoRoute(
      path: Routes.SHIPMENT_TRACKING,
      builder: (context, state) => const ShipmentTracking(),
    ),
    GoRoute(
      path: Routes.TRACKING_RESULT,
      builder: (context, state) {
        final trackingId = state.extra as String;
        return TrackingResult(trackingId: trackingId);
      },
    ),
    GoRoute(
      path: Routes.WEIGHT_DISC,
      builder: (context, state) => const WeightDiscrepancy(),
    ),
    GoRoute(
      path: Routes.SELLER_CHARGES,
      builder: (context, state) => const SellerChargesScreen(),
    ),
    GoRoute(
      path: Routes.RATE_CALCULATOR,
      builder: (context, state) => const ShipmentRateCalculator(),
    ),
    GoRoute(
      path: Routes.TRANSACTION_SUMMARY,
      builder: (context, state) => const TransactionSummary(),
    ),
  ],
);
