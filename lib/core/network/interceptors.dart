import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/features/user/presentation/state/user_balance_notifier.dart';
import 'package:sharkship/routes/app_router.dart';
import '../services/auth_service.dart';

class AuthInterceptor extends Interceptor {
  final AuthService authService;
  final Ref ref;

  AuthInterceptor(this.authService, this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authService.getToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final path = err.requestOptions.path;
      // Exclude login and registration paths from auto-logout logic
      final isAuthPath =
          path.contains('/v1/auth/login') ||
          path.contains('/v1/auth/otp-login') ||
          path.contains('/v1/auth/generate-otp') ||
          path.contains('/v1/user/register') ||
          path.contains('/v1/user/authenticateUser');

      if (!isAuthPath) {
        // Only trigger logout if we actually have a token to clear.
        // This prevents the infinite 401 loop when UserNotifier tries to re-fetch.
        final token = await authService.getToken();
        if (token == null) return;

        // 1. Clear Secure Storage (tokens and user data)
        await authService.logout();

        // 2. Clear Hive Box (profile data)
        try {
          final box = Hive.box('user_box');
          await box.clear();
        } catch (_) {}

        // 3. Reset Riverpod State
        // Use refresh instead of invalidate to force an immediate reset if needed,
        // but avoid circular dependencies.
        ref.invalidate(userProvider);
        ref.invalidate(userBalanceProvider);

        // 4. Navigate to sign-in and clear previous routes
        appRouter.go(Routes.SIGNIN);
      }
    }

    handler.next(err);
  }
}
