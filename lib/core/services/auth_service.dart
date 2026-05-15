import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthService {
  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    print('savging');
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> saveAccess({required String accessToken}) async {
    print('savging');
    await _storage.write(key: 'access_token', value: accessToken);
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _storage.write(key: 'user_data', value: jsonEncode(userData));
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final str = await _storage.read(key: 'user_data');
    if (str != null) return jsonDecode(str);
    return null;
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}
