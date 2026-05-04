import 'package:dio/dio.dart';
import '../models/coupon_model.dart';
import '../models/coupon_validation_model.dart';
import '../models/payment_initiate_model.dart';
import '../models/payment_confirm_model.dart';

abstract class WalletRemoteDataSource {
  Future<List<CouponModel>> getCoupons();
  Future<CouponValidationModel> validateCoupon(
    String couponCode,
    double amount,
  );
  Future<PaymentInitiateModel> initiatePayment({
    required double amount,
    String? couponCode,
    required String paymentGateway,
  });
  Future<PaymentConfirmModel> confirmPayment({
    required String orderId,
    required String paymentId,
    required String signature,
    required String paymentGateway,
  });
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final Dio dio;

  WalletRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CouponModel>> getCoupons() async {
    final response = await dio.get('/v1/user/coupons');

    // Based on the provided response, it's a list of objects
    final List<dynamic> data = response.data;
    return data.map((json) => CouponModel.fromJson(json)).toList();
  }

  @override
  Future<CouponValidationModel> validateCoupon(
    String couponCode,
    double amount,
  ) async {
    final response = await dio.post(
      '/v1/user/validate-coupon',
      data: {
        'coupon_code': couponCode,
        'amount': amount,
      },
    );

    return CouponValidationModel.fromJson(response.data);
  }

  @override
  Future<PaymentInitiateModel> initiatePayment({
    required double amount,
    String? couponCode,
    required String paymentGateway,
  }) async {
    final response = await dio.post(
      '/v1/finance/payment-initiate',
      data: {
        'amount': amount,
        if (couponCode != null) 'coupon_code': couponCode,
        'paymentGateway': paymentGateway,
      },
    );

    final data = response.data['data'] ?? response.data;
    return PaymentInitiateModel.fromJson(data);
  }

  @override
  Future<PaymentConfirmModel> confirmPayment({
    required String orderId,
    required String paymentId,
    required String signature,
    required String paymentGateway,
  }) async {
    final response = await dio.post(
      '/v1/finance/payment-gateway-confirm',
      data: {
        'orderId': orderId,
        'paymentId': paymentId,
        'signature': signature,
        'paymentGateway': paymentGateway,
      },
    );

    return PaymentConfirmModel.fromJson(response.data);
  }
}
