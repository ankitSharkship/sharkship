// dio_exception_handler.dart

import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handle(dynamic e) {
    if (e is DioException) {
      // Try to extract message from JSON body first
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response!.data as Map<String, dynamic>;
        final msg = data['message'] ?? data['error'] ?? data['msg'];
        if (msg != null) return msg.toString();
      }

      // Fall back to status-code-aware messages
      final statusCode = e.response?.statusCode;
      switch (statusCode) {
        case 401:
          return "Session expired. Please log in again.";
        case 403:
          return "You don't have permission to do this.";
        case 429:
          return "Too many requests. Please slow down.";
        case 500:
        case 502:
        case 503:
          return "Server error. Please try again later.";
      }

      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return "Connection timeout. Please check your internet.";
        case DioExceptionType.cancel:
          return "Request was cancelled.";
        case DioExceptionType.connectionError:
          return "No internet connection.";
        default:
          return "Something went wrong.";
      }
    }
    return e.toString();
  }
}
