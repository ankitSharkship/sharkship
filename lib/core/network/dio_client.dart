import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/network/interceptors.dart';
import '../services/auth_service.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);

  factory DioClient.create(AuthService authService, Ref ref) {
    final dio = Dio(
      BaseOptions(
        // baseUrl: "http://192.168.1.103:3000/",
        baseUrl: "https://staging-api.sharkship.in/",
        // baseUrl: 'https://api.sharkship.in/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.addAll([
      AuthInterceptor(authService, ref),
      LogInterceptor(responseBody: true, requestBody: true),
    ]);
    return DioClient(dio);
  }
}
