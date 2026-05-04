import '../entities/coupon_entity.dart';
import '../repositories/wallet_repository.dart';

class GetCouponsUseCase {
  final WalletRepository repository;

  GetCouponsUseCase(this.repository);

  Future<List<CouponEntity>> call() {
    return repository.getCoupons();
  }
}
