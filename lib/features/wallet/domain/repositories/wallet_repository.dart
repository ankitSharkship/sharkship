import '../entities/coupon_entity.dart';
import '../entities/coupon_validation_entity.dart';
import '../entities/payment_initiate_entity.dart';
import '../entities/payment_confirm_entity.dart';

abstract class WalletRepository {
  Future<List<CouponEntity>> getCoupons();
  Future<CouponValidationEntity> validateCoupon(
    String couponCode,
    double amount,
  );
  Future<PaymentInitiateEntity> initiatePayment({
    required double amount,
    String? couponCode,
    required String paymentGateway,
  });
  Future<PaymentConfirmEntity> confirmPayment({
    required String orderId,
    required String paymentId,
    required String signature,
    required String paymentGateway,
  });
}
