import '../entities/user.dart';

abstract class UserRepository {
  Future<User> getUserDetails();
  Future<void> saveUserLocally(User user);
  Future<User?> getUserFromLocalStorage();
  Future<void> clearUserFromLocalStorage();
}
