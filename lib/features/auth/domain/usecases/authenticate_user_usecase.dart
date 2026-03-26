import 'package:sharkship/features/auth/domain/entities/authenticate_user_response.dart';
import '../repositories/auth_repository.dart';

class AuthenticateUserUseCase {
  final AuthRepository repository;

  AuthenticateUserUseCase(this.repository);

  Future<AuthenticateUser> call(String phone) {
    return repository.authenticateUser(phone);
  }
}
