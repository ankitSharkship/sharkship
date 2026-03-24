import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class OtpLoginUseCase {
  final AuthRepository repository;

  OtpLoginUseCase(this.repository);

  Future<LoginResponse> call(String phoneNo, String verifyId, String otp) {
    return repository.otpLogin(phoneNo, verifyId, otp);
  }
}
