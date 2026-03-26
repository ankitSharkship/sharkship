import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/auth/domain/usecases/authenticate_user_usecase.dart';
import 'package:sharkship/features/auth/domain/usecases/register_user_usecase.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/generate_otp_usecase.dart';
import '../../domain/usecases/otp_login_usecase.dart';
import '../../domain/usecases/password_login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'auth_providers.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return AuthRemoteDataSourceImpl(dio);
}

@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthLocalDataSourceImpl(authService);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource, localDataSource);
}

@riverpod
GenerateOtpUseCase generateOtpUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GenerateOtpUseCase(repository);
}

@riverpod
OtpLoginUseCase otpLoginUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return OtpLoginUseCase(repository);
}

@riverpod
PasswordLoginUseCase passwordLoginUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return PasswordLoginUseCase(repository);
}

@riverpod
LogoutUseCase logoutUseCase(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
}

@riverpod
AuthenticateUserUseCase authenticateUserUseCase(Ref ref) {
  return AuthenticateUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
RegisterUserUseCase registerUserUseCase(Ref ref) {
  return RegisterUserUseCase(ref.watch(authRepositoryProvider));
}
