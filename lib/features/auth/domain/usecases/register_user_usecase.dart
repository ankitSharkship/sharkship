import 'package:sharkship/features/auth/data/models/register_user_request_model.dart';
import 'package:sharkship/features/auth/domain/entities/login_response.dart';
import 'package:sharkship/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<LoginResponse> call(
    RegisterUserRequestModel request,
  ) {
    return repository.registerUser(request);
  }
}