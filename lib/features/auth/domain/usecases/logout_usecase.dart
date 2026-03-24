import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call({bool allSession = false}) {
    return repository.logout(allSession: allSession);
  }
}
