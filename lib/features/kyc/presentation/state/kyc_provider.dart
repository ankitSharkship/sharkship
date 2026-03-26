import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/providers/app_providers.dart';

import '../../data/datasources/kyc_remote_datasource.dart';
import '../../data/datasources/kyc_remote_datasource_impl.dart';
import '../../data/repositories/kyc_repository_impl.dart';

import '../../domain/repositories/kyc_repository.dart';
import '../../domain/usecases/verify_pan_usecase.dart';
import '../../domain/usecases/upload_aadhar_usecase.dart';

// part 'kyc_provider.g.dart';

// ---------- DATASOURCE ----------

final kycRemoteDataSourceProvider = Provider<KycRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return KycRemoteDataSourceImpl(dio);
});

// ---------- REPOSITORY ----------
final kycRepositoryProvider = Provider<KycRepository>((ref) {
  return KycRepositoryImpl(ref.read(kycRemoteDataSourceProvider));
});

// ---------- USECASES ----------
final verifyPanUseCaseProvider = Provider<VerifyPanUseCase>((ref) {
  return VerifyPanUseCase(ref.read(kycRepositoryProvider));
});

final uploadAadharUseCaseProvider = Provider<UploadAadharUsecase>((ref) {
  return UploadAadharUsecase(ref.read(kycRepositoryProvider));
});
