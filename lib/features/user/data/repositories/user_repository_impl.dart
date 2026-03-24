import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<User> getUserDetails() async {
    return await remoteDataSource.getUserDetails();
  }

  @override
  Future<void> saveUserLocally(User user) async {
    if (user is UserModel) {
      await localDataSource.saveUser(user);
    } else {
      // If we got a User entity, we might need a converter or factory to UserModel
      // For now, assume remote results are UserModel
    }
  }

  @override
  Future<User?> getUserFromLocalStorage() async {
    return await localDataSource.getUser();
  }

  @override
  Future<void> clearUserFromLocalStorage() async {
    await localDataSource.clearUser();
  }
}
