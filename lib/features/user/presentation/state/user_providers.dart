import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/user_local_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_user_details_usecase.dart';
import '../../domain/usecases/get_user_balance_usecase.dart';
import '../../domain/usecases/change_password_usecase.dart';
import '../../domain/usecases/generate_otp_for_password_usecase.dart';
import '../../domain/usecases/update_personal_info_usecase.dart';
import '../../domain/usecases/upload_logo_usecase.dart';

part 'user_providers.g.dart';

@Riverpod(keepAlive: true)
Box userHiveBox(Ref ref) {
  return Hive.box('user_box');
}

@riverpod
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return UserRemoteDataSourceImpl(dio);
}

@riverpod
UserLocalDataSource userLocalDataSource(Ref ref) {
  final box = ref.watch(userHiveBoxProvider);
  return UserLocalDataSourceImpl(box);
}

@riverpod
UserRepository userRepository(Ref ref) {
  final remote = ref.watch(userRemoteDataSourceProvider);
  final local = ref.watch(userLocalDataSourceProvider);
  return UserRepositoryImpl(remote, local);
}

@riverpod
GetUserDetailsUseCase getUserDetailsUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserDetailsUseCase(repository);
}

@riverpod
GetUserBalanceUseCase getUserBalanceUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserBalanceUseCase(repository);
}

@riverpod
GenerateOtpForPasswordUseCase generateOtpForPasswordUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GenerateOtpForPasswordUseCase(repository);
}

@riverpod
ChangePasswordUseCase changePasswordUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return ChangePasswordUseCase(repository);
}

@riverpod
UpdatePersonalInfoUseCase updatePersonalInfoUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdatePersonalInfoUseCase(repository);
}

@riverpod
UploadLogoUseCase uploadLogoUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UploadLogoUseCase(repository);
}
