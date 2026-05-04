import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/wallet/data/repositories/payment_repository_impl.dart';
import '../../../../core/providers/app_providers.dart';
import '../../data/datasources/wallet_remote_datasource.dart';
import '../../data/repositories/wallet_repository_impl.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../../domain/usecases/get_coupons_usecase.dart';
import '../../domain/usecases/validate_coupon_usecase.dart';
import '../../domain/usecases/initiate_payment_usecase.dart';
import '../../domain/usecases/confirm_payment_usecase.dart';

part 'wallet_providers.g.dart';

@riverpod
WalletRemoteDataSource walletRemoteDataSource(Ref ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return WalletRemoteDataSourceImpl(dio);
}

@riverpod
WalletRepository walletRepository(Ref ref) {
  final remoteDataSource = ref.watch(walletRemoteDataSourceProvider);
  return WalletRepositoryImpl(remoteDataSource);
}


@riverpod
GetCouponsUseCase getCouponsUseCase(Ref ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return GetCouponsUseCase(repository);
}

@riverpod
ValidateCouponUseCase validateCouponUseCase(Ref ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return ValidateCouponUseCase(repository);
}

@riverpod
InitiatePaymentUseCase initiatePaymentUseCase(Ref ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return InitiatePaymentUseCase(repository);
}

@riverpod
ConfirmPaymentUseCase confirmPaymentUseCase(Ref ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return ConfirmPaymentUseCase(repository);
}


