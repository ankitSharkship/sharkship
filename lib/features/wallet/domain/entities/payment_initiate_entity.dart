import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_initiate_entity.freezed.dart';

@freezed
sealed class PaymentInitiateEntity with _$PaymentInitiateEntity {
  const factory PaymentInitiateEntity.cashfree({
    required String orderId,
    required String cfOrderId,
    required String paymentSessionId,
    required num amount,
    required DateTime createdAt,
    required String status,
  }) = CashfreeInitiateEntity;

  const factory PaymentInitiateEntity.razorpay({
    required String orderId,
    required String id,
    required num amount,
    required num amountDue,
    required num amountPaid,
    required String currency,
    required DateTime createdAt,
    required String status,
  }) = RazorpayInitiateEntity;

  const factory PaymentInitiateEntity.payu({
    required String orderId,
    required String key,
    required String txnid,
    required num amount,
    required String hash,
    required String surl,
    required String furl,
    required String productInfo,
    required String firstName,
    required String email,
    required String phone,
  }) = PayUInitiateEntity;
}
