import '../repositories/user_repository.dart';

class ChangePasswordUseCase {
  final UserRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call({
    required String verifyId,
    required String otp,
    required String newPassword,
  }) {
    return repository.changePassword(
      verifyId: verifyId,
      otp: otp,
      newPassword: newPassword,
    );
  }
}
