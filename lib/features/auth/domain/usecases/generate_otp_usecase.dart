import '../entities/otp_response.dart';
import '../repositories/auth_repository.dart';

class GenerateOtpUseCase {
  final AuthRepository repository;

  GenerateOtpUseCase(this.repository);

  Future<OtpResponse> call(String phoneNo) {
    return repository.generateOtp(phoneNo);
  }
}
