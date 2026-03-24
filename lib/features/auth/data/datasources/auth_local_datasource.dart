import '../../../../core/services/auth_service.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthData(Map<String, dynamic> data, String accessToken, String refreshToken);
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AuthService authService;

  AuthLocalDataSourceImpl(this.authService);

  @override
  Future<void> saveAuthData(
      Map<String, dynamic> data, String accessToken, String refreshToken) async {
    await authService.saveTokens(
        accessToken: accessToken, refreshToken: refreshToken);
    await authService.saveUserData(data);
  }

  @override
  Future<void> clearAuthData() async {
    await authService.logout();
  }
}
