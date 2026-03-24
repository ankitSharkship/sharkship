import 'package:dio/dio.dart';
import 'package:sharkship/core/network/interceptors.dart';
import '../services/auth_service.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);

  factory DioClient.create(AuthService authService) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://api.sharkship.in/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(authService),
      LogInterceptor(responseBody: true, requestBody: true),
    ]);

    return DioClient(dio);
  }
}
