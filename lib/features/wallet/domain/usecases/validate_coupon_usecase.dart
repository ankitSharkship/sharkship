import '../entities/coupon_validation_entity.dart';
import '../repositories/wallet_repository.dart';

class ValidateCouponUseCase {
  final WalletRepository repository;

  ValidateCouponUseCase(this.repository);

  Future<CouponValidationEntity> call(String couponCode, double amount) {
    return repository.validateCoupon(couponCode, amount);
  }
}
