import '../entities/login_response.dart';
import '../entities/otp_response.dart';

abstract class AuthRepository {
  Future<OtpResponse> generateOtp(String phoneNo);
  Future<LoginResponse> otpLogin(String phoneNo, String verifyId, String otp);
  Future<LoginResponse> passwordLogin(String phoneNo, String password);
  Future<void> logout({bool allSession = false});
}
