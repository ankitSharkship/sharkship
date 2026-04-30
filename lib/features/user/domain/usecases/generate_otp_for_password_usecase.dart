import '../repositories/user_repository.dart';

class GenerateOtpForPasswordUseCase {
  final UserRepository repository;

  GenerateOtpForPasswordUseCase(this.repository);

  /// Returns the [verifyId] string to be used in the change-password call.
  Future<String> call(String phoneNo) {
    return repository.generateOtpForPasswordChange(phoneNo);
  }
}
