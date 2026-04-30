import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/user_balance_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserDetails();
  Future<UserBalanceModel> getUserBalance();
  Future<String> generateOtpForPasswordChange(String phoneNo);
  Future<void> changePassword({
    required String verifyId,
    required String otp,
    required String newPassword,
  });
  Future<void> updatePersonalInfo({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNo,
    required String businessName,
    required String typeOfBusiness,
    required String otp,
    required String verifyId,
  });
  Future<void> uploadLogo(String filePath);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> getUserDetails() async {
    final response = await dio.get('/v1/user/details');
    final data = response.data['data'] ?? response.data;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserBalanceModel> getUserBalance() async {
    final response = await dio.get('/v1/finance/get-Balance');
    final data = response.data['data'] ?? response.data;
    return UserBalanceModel.fromJson(data);
  }

  @override
  Future<String> generateOtpForPasswordChange(String phoneNo) async {
    final response = await dio.post(
      '/v1/auth/generate-otp',
      data: {'phone_no': phoneNo, 'otp_type': 'VERIFY'},
      options: Options(
        headers: {
          'api_key': '4e8755af-0b26-4040-bf1d-a1f76a7d1f4d',
          'client': 'SHARKSHIP_FE_CLIENT',
        },
      ),
    );
    final data = response.data['data'] ?? response.data;
    return data['verify_id'] as String;
  }

  @override
  Future<void> changePassword({
    required String verifyId,
    required String otp,
    required String newPassword,
  }) async {
    await dio.put(
      '/v1/user/change-password',
      data: {'verify_id': verifyId, 'otp': otp, 'newPassword': newPassword},
    );
  }

  @override
  Future<void> updatePersonalInfo({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNo,
    required String businessName,
    required String typeOfBusiness,
    required String otp,
    required String verifyId,
  }) async {
    await dio.put(
      '/v1/user/update-personal-info/$userId',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'business_name': businessName,
        'email': email,
        'phone_no': phoneNo,
        'type_of_business': typeOfBusiness,
        'otp': otp,
        'verify_id': verifyId,
      },
    );
  }

  @override
  Future<void> uploadLogo(String filePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      ),
    });

    await dio.post(
      '/v1/user/logo',
      data: formData,
      options: Options(
        headers: {
          'category': 'PROFILE',
        },
      ),
    );
  }
}
