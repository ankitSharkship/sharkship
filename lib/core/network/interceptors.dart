// interceptors.dart

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sharkship/core/services/auth_service.dart';
import 'package:sharkship/features/auth/data/models/login_response_model.dart';
 
class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AuthService authService;
  final Future<void> Function() onUnauthenticated;
  Completer<void>? _refreshCompleter;
  bool _isLoggingOut = false;

  AuthInterceptor({
    required this.dio,
    required this.authService,
    required this.onUnauthenticated,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Don't add Authorization header to the refresh token endpoint itself
    if (options.path.contains('/v1/auth/refresh_token_login')) {
      return handler.next(options);
    }

    final token = await authService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // If we get a successful response, we can safely reset the logging out flag
    // (though usually navigation will have handled this by recreating the interceptor)
    _isLoggingOut = false;
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final path = err.requestOptions.path;

    // 2. Auth paths (login, register, etc.) should not trigger refresh/logout logic
    final isAuthPath =
        path.contains('/v1/auth/login') ||
        path.contains('/v1/auth/otp-login') ||
        path.contains('/v1/auth/generate-otp') ||
        path.contains('/v1/auth/logout') ||
        path.contains('/v1/auth/refresh_token_login') ||
        path.contains('/v1/user/register') ||
        path.contains('/v1/user/authenticateUser');

    if (isAuthPath) {
      return handler.next(err);
    }

    // 3. Skip if we are already in the process of logging out
    if (_isLoggingOut) {
      return handler.next(err);
    }

    // 4. Handle "Already Retried" case
    // If a request was already retried once and still gets a 401, it's a fatal auth error
    if (err.requestOptions.extra['isRetry'] == true) {
      await _handleLogout();
      return handler.next(err);
    }

    // 5. Handle "No Token" case
    // If we have no token but get a 401, we are essentially unauthenticated
    final token = await authService.getToken();
    if (token == null || token.isEmpty) {
      await _handleLogout();
      return handler.next(err);
    }

    // 6. Concurrency guard: If a refresh is already in progress, wait for it
    if (_refreshCompleter != null) {
      try {
        await _refreshCompleter!.future;
        // After success, retry the request
        return _retry(err.requestOptions, handler);
      } catch (e) {
        // If the shared refresh failed, the leader will have triggered logout.
        // We just propagate the error.
        return handler.next(err);
      }
    }

    // 7. No refresh in progress, start one
    _refreshCompleter = Completer<void>();

    try {
      final success = await _performRefresh();
      if (success) {
        _refreshCompleter!.complete();
        return _retry(err.requestOptions, handler);
      } else {
        throw Exception('Refresh failed');
      }
    } catch (e) {
      _refreshCompleter!.completeError(e);
      // If refresh failed, trigger the global logout
      await _handleLogout();
      return handler.next(err);
    } finally {
      // Small delay before clearing to ensure all pending awaiters have resumed
      Future.delayed(const Duration(seconds: 1), () {
        _refreshCompleter = null;
      });
    }
  }

  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    try {
      await onUnauthenticated();
    } finally {
      // We don't reset _isLoggingOut because the app should be restarting/navigating away
      // but if we did, we would do it here.
    }
  }

  Future<bool> _performRefresh() async {
    final refreshToken = await authService.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // Create a fresh dio instance or use a specific one for refresh to avoid interceptor recursion
      // but since we check for the refresh path in onRequest/onError, it should be fine.
      final response = await dio.get(
        '/v1/auth/refresh_token_login',
        options: Options(headers: {'x-refresh-token': refreshToken}),
      );

      final data = response.data['data'] ?? response.data;
      final model = LoginResponseModel.fromJson(data);

      if (model.accessToken != null && model.refreshToken != null) {
        await authService.saveTokens(
          accessToken: model.accessToken!,
          refreshToken: model.refreshToken!,
        );
        // Also update full user metadata if available
        await authService.saveUserData(model.toJson());
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _retry(
    RequestOptions options,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      // Get the new token
      final newToken = await authService.getToken();
      if (newToken != null) {
        options.headers['Authorization'] = 'Bearer $newToken';
      }

      // Mark as retry to prevent loops
      options.extra['isRetry'] = true;

      final response = await dio.fetch(options);
      return handler.resolve(response);
    } catch (e) {
      if (e is DioException) {
        return handler.next(e);
      }
      return handler.next(DioException(requestOptions: options, error: e));
    }
  }
}
