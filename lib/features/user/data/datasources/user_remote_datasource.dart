import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/user_balance_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserDetails();
  Future<UserBalanceModel> getUserBalance();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> getUserDetails() async {
    final response = await dio.get('/v1/user/details');
    // Ensure we handle response structure correctly (sometimes it might be wrapped in { "data": ... })
    final data = response.data['data'] ?? response.data;
    return UserModel.fromJson(data);
  }

  @override
  Future<UserBalanceModel> getUserBalance() async {
    final response = await dio.get('/v1/finance/get-Balance');
    final data = response.data['data'] ?? response.data;
    return UserBalanceModel.fromJson(data);
  }
}
