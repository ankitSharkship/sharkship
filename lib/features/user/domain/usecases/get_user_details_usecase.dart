import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUserDetailsUseCase {
  final UserRepository repository;

  GetUserDetailsUseCase(this.repository);

  Future<User> call() async {
    final user = await repository.getUserDetails();
    await repository.saveUserLocally(user);
    return user;
  }
}
