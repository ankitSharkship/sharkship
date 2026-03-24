import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class PasswordLoginUseCase {
  final AuthRepository repository;

  PasswordLoginUseCase(this.repository);

  Future<LoginResponse> call(String phoneNo, String password) {
    return repository.passwordLogin(phoneNo, password);
  }
}
