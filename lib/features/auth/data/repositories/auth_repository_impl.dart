import '../../domain/entities/login_response.dart';
import '../../domain/entities/otp_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<OtpResponse> generateOtp(String phoneNo) async {
    return await remoteDataSource.generateOtp(phoneNo);
  }

  @override
  Future<LoginResponse> otpLogin(
      String phoneNo, String verifyId, String otp) async {
    final response = await remoteDataSource.otpLogin(phoneNo, verifyId, otp);
    
    if (response.accessToken != null && response.refreshToken != null) {
      await localDataSource.saveAuthData(
        response.toJson(),
        response.accessToken!,
        response.refreshToken!,
      );
    }
    return response;
  }

  @override
  Future<LoginResponse> passwordLogin(String phoneNo, String password) async {
    final response = await remoteDataSource.passwordLogin(phoneNo, password);
    
    if (response.accessToken != null && response.refreshToken != null) {
      await localDataSource.saveAuthData(
        response.toJson(),
        response.accessToken!,
        response.refreshToken!,
      );
    }
    return response;
  }

  @override
  Future<void> logout({bool allSession = false}) async {
    await localDataSource.clearAuthData();
    remoteDataSource.logout(allSession: allSession).ignore();
  }
}
