import '../entities/user.dart';
import '../entities/user_balance.dart';

abstract class UserRepository {
  Future<User> getUserDetails();
  Future<void> saveUserLocally(User user);
  Future<User?> getUserFromLocalStorage();
  Future<void> clearUserFromLocalStorage();
  Future<UserBalance> getUserBalance();
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
