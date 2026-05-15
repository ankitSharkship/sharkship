// dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/core/services/shared_preferences_service.dart';
import 'package:sharkship/features/auth/presentation/state/auth_providers.dart';
import 'package:sharkship/features/user/presentation/state/user_role.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/core/network/interceptors.dart';
import '../services/auth_service.dart';

class DioClient {
  final Dio dio;
  DioClient(this.dio);

  factory DioClient.create(AuthService authService, Ref ref) {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? "",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // All provider reads happen HERE — outside the interceptor,
    // at construction time, where there is no circular dependency.
    Future<void> handleUnauthenticated() async {
      // 1. Call logout API (best effort)
      try {
        final useCase = ref.read(logoutUseCaseProvider);
        await useCase(allSession: false);
        Posthog().capture(eventName: 'user_logout');
        await Posthog().reset();
      } catch (_) {}

      // 2. Clear local state
      await authService.logout();
      ref.read(userRoleProvider.notifier).state = null;
      ref.read(supportRoleUserDetailsProvider.notifier).state = null;
      await SharedPreferencesService.clearUserRole();
      await SharedPreferencesService.clearSupportDetails();

      // 3. Reset app and navigate
      ref.read(appContainerKeyProvider.notifier).state = UniqueKey();
      appRouter.go(Routes.SIGNIN);
    }

    dio.interceptors.addAll([
      AuthInterceptor(
        dio: dio,
        authService: authService,
        onUnauthenticated: handleUnauthenticated,
      ),
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: false,
      ),
    ]);

    return DioClient(dio);
  }
}
