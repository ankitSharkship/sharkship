import '../entities/user.dart';
import '../entities/user_balance.dart';

abstract class UserRepository {
  Future<User> getUserDetails();
  Future<void> saveUserLocally(User user);
  Future<User?> getUserFromLocalStorage();
  Future<void> clearUserFromLocalStorage();
  Future<UserBalance> getUserBalance();
}
