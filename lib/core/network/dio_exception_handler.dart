import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handle(dynamic e) {
    if (e is DioException) {
      String message = "Something went wrong";
      
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response?.data as Map<String, dynamic>;
        // Extract message from standard backend error keys
        message = data['message'] ?? data['error'] ?? data['msg'] ?? message;
      } else {
        switch (e.type) {
          case DioExceptionType.connectionTimeout:
          case DioExceptionType.sendTimeout:
          case DioExceptionType.receiveTimeout:
            message = "Connection timeout. Please check your internet.";
            break;
          case DioExceptionType.cancel:
            message = "Request was cancelled.";
            break;
          case DioExceptionType.connectionError:
            message = "No internet connection.";
            break;
          case DioExceptionType.badResponse:
            message = "Server error: ${e.response?.statusCode}";
            break;
          default:
            message = "An unexpected error occurred.";
        }
      }
      return message;
    }
    return e.toString();
  }
}
