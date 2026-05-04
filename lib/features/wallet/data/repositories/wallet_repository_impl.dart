import '../../domain/entities/coupon_entity.dart';
import '../../domain/entities/coupon_validation_entity.dart';
import '../../domain/entities/payment_initiate_entity.dart';
import '../../domain/entities/payment_confirm_entity.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CouponEntity>> getCoupons() async {
    return await remoteDataSource.getCoupons();
  }

  @override
  Future<CouponValidationEntity> validateCoupon(
    String couponCode,
    double amount,
  ) async {
    return await remoteDataSource.validateCoupon(couponCode, amount);
  }

  @override
  Future<PaymentInitiateEntity> initiatePayment({
    required double amount,
    String? couponCode,
    required String paymentGateway,
  }) async {
    return await remoteDataSource.initiatePayment(
      amount: amount,
      couponCode: couponCode,
      paymentGateway: paymentGateway,
    );
  }

  @override
  Future<PaymentConfirmEntity> confirmPayment({
    required String orderId,
    required String paymentId,
    required String signature,
    required String paymentGateway,
  }) async {
    return await remoteDataSource.confirmPayment(
      orderId: orderId,
      paymentId: paymentId,
      signature: signature,
      paymentGateway: paymentGateway,
    );
  }
}
