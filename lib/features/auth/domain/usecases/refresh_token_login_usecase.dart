import 'package:sharkship/features/auth/domain/entities/login_response.dart';
import 'package:sharkship/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenLoginUseCase {
  final AuthRepository repository;

  RefreshTokenLoginUseCase(this.repository);

  Future<LoginResponse> execute(String refreshToken) async {
    return await repository.refreshTokenLogin(refreshToken);
  }
}
