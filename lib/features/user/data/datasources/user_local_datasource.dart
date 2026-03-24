import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
  Future<void> clearUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box userBox;

  UserLocalDataSourceImpl(this.userBox);

  @override
  Future<void> saveUser(UserModel user) async {
    await userBox.put('profile', jsonEncode(user.toJson()));
  }

  @override
  Future<UserModel?> getUser() async {
    final data = userBox.get('profile');
    if (data != null) {
      return UserModel.fromJson(jsonDecode(data));
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await userBox.delete('profile');
  }
}
