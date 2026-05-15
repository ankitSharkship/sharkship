import 'package:sharkship/features/auth/data/models/register_user_request_model.dart';
import 'package:sharkship/features/auth/domain/entities/authenticate_user_response.dart';

import '../entities/login_response.dart';
import '../entities/otp_response.dart';

abstract class AuthRepository {
  Future<OtpResponse> generateOtp(String phoneNo);
  Future<LoginResponse> otpLogin(String phoneNo, String verifyId, String otp);
  Future<LoginResponse> passwordLogin(String phoneNo, String password);
  Future<void> logout({bool allSession = false});
  Future<AuthenticateUser> authenticateUser(String phone);
  Future<LoginResponse> registerUser(RegisterUserRequestModel request);
  Future<LoginResponse> refreshTokenLogin(String refreshToken);
}
