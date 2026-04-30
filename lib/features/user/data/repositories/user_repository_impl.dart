import '../../domain/entities/user_balance.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<User> getUserDetails() async {
    return await remoteDataSource.getUserDetails();
  }

  @override
  Future<void> saveUserLocally(User user) async {
    if (user is UserModel) {
      await localDataSource.saveUser(user);
    }
  }

  @override
  Future<User?> getUserFromLocalStorage() async {
    return await localDataSource.getUser();
  }

  @override
  Future<void> clearUserFromLocalStorage() async {
    await localDataSource.clearUser();
  }

  @override
  Future<UserBalance> getUserBalance() async {
    return await remoteDataSource.getUserBalance();
  }

  @override
  Future<String> generateOtpForPasswordChange(String phoneNo) async {
    return await remoteDataSource.generateOtpForPasswordChange(phoneNo);
  }

  @override
  Future<void> changePassword({
    required String verifyId,
    required String otp,
    required String newPassword,
  }) async {
    await remoteDataSource.changePassword(
      verifyId: verifyId,
      otp: otp,
      newPassword: newPassword,
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
    await remoteDataSource.updatePersonalInfo(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNo: phoneNo,
      businessName: businessName,
      typeOfBusiness: typeOfBusiness,
      otp: otp,
      verifyId: verifyId,
    );
  }

  @override
  Future<void> uploadLogo(String filePath) async {
    await remoteDataSource.uploadLogo(filePath);
  }
}
