import 'package:dio/dio.dart';
import '../models/otp_response_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<OtpResponseModel> generateOtp(String phoneNo);
  Future<LoginResponseModel> otpLogin(
      String phoneNo, String verifyId, String otp);
  Future<LoginResponseModel> passwordLogin(String phoneNo, String password);
  Future<void> logout({bool allSession = false});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<OtpResponseModel> generateOtp(String phoneNo) async {
    final response = await dio.post(
      '/v1/auth/generate-otp',
      data: {
        "phone_no": phoneNo,
        "otp_type": "LOGIN",
      },
      options: Options(
        headers: {
          "api_key": "4e8755af-0b26-4040-bf1d-a1f76a7d1f4d",
          "client": "SHARKSHIP_FE_CLIENT",
        },
      ),
    );

    // Attempt parsing directly or from 'data' field
    final data = response.data['data'] ?? response.data;
    return OtpResponseModel.fromJson(data);
  }

  @override
  Future<LoginResponseModel> otpLogin(
      String phoneNo, String verifyId, String otp) async {
    final response = await dio.post(
      '/v1/auth/otp-login',
      data: {
        "phone_no": phoneNo,
        "verify_id": verifyId,
        "otp": otp,
      },
      options: Options(
        headers: {
          "api_key": "4e8755af-0b26-4040-bf1d-a1f76a7d1f4d",
          "client": "SHARKSHIP_FE_CLIENT",
        },
      ),
    );

    final data = response.data['data'] ?? response.data;
    return LoginResponseModel.fromJson(data);
  }

  @override
  Future<LoginResponseModel> passwordLogin(
      String phoneNo, String password) async {
    final response = await dio.post(
      '/v1/auth/login',
      data: {
        "phone_no": phoneNo,
        "password": password,
      },
    );

    final data = response.data['data'] ?? response.data;
    return LoginResponseModel.fromJson(data);
  }

  @override
  Future<void> logout({bool allSession = false}) async {
    await dio.post(
      '/v1/auth/logout',
      data: {
        "allSession": allSession,
      },
    );
  }
}
