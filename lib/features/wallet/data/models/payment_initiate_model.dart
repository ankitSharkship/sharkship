import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/payment_initiate_entity.dart';

part 'payment_initiate_model.freezed.dart';

@freezed
class PaymentInitiateModel with _$PaymentInitiateModel {
  const PaymentInitiateModel._();
  String get orderId => when(
    cashfree: (orderId, _, __, ___, ____, _____) => orderId,
    razorpay: (orderId, _, __, ___, ____, _____, ______, _______) => orderId,
    payu:
        (
          orderId,
          _,
          __,
          ___,
          ____,
          _____,
          ______,
          _______,
          ________,
          _________,
          __________,
        ) => orderId,
  );

  num get amount => when(
    cashfree: (_, __, ___, amount, ____, _____) => amount,
    razorpay: (_, __, amount, ____, _____, ______, _______, ________) => amount,
    payu:
        (
          _,
          __,
          ___,
          amount,
          ____,
          _____,
          ______,
          _______,
          ________,
          _________,
          __________,
        ) => amount,
  );

  const factory PaymentInitiateModel.cashfree({
    required String orderId,
    required String cfOrderId,
    required String paymentSessionId,
    required num amount,
    required DateTime createdAt,
    required String status,
  }) = CashfreeInitiateModel;

  const factory PaymentInitiateModel.razorpay({
    required String orderId,
    required String id,
    required num amount,
    required num amountDue,
    required num amountPaid,
    required String currency,
    required DateTime createdAt,
    required String status,
  }) = RazorpayInitiateModel;

  const factory PaymentInitiateModel.payu({
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
  }) = PayUInitiateModel;

  factory PaymentInitiateModel.fromResponse(
    Map<String, dynamic> json,
    String gateway,
  ) {
    final String orderId = json['orderId'] as String;
    switch (gateway.toUpperCase()) {
      case 'CASHFREE':
        final data = json['data'] as Map<String, dynamic>;
        return PaymentInitiateModel.cashfree(
          orderId: data['order_id'],
          cfOrderId: data['cf_order_id'] as String,
          paymentSessionId: data['payment_session_id'] as String,
          amount: data['order_amount'] as num,
          createdAt: DateTime.parse(data['created_at'] as String),
          status: data['order_status'] as String,
        );

      case 'RAZORPAY':
        return PaymentInitiateModel.razorpay(
          orderId: orderId,
          id: json['id'] as String,
          amount: json['amount'] as num,
          amountDue: json['amount_due'] as num,
          amountPaid: json['amount_paid'] as num,
          currency: json['currency'] as String,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
            (json['created_at'] as int) * 1000,
          ),
          status: json['status'] as String,
        );

      case 'PAYU':
        final data = json['data'] as Map<String, dynamic>;
        return PaymentInitiateModel.payu(
          orderId: orderId,
          key: data['key'] as String,
          txnid: data['txnid'] as String,
          amount: num.parse(data['amount'].toString()),
          hash: data['hash'] as String,
          surl: data['surl'] as String,
          furl: data['furl'] as String,
          productInfo: data['productinfo'] as String,
          firstName: data['firstname'] as String,
          email: data['email'] as String,
          phone: data['phone'] as String,
        );

      default:
        throw Exception('Unsupported payment gateway: $gateway');
    }
  }

  PaymentInitiateEntity toEntity() {
    return when(
      cashfree:
          (orderId, cfOrderId, paymentSessionId, amount, createdAt, status) =>
              PaymentInitiateEntity.cashfree(
                orderId: orderId,
                cfOrderId: cfOrderId,
                paymentSessionId: paymentSessionId,
                amount: amount,
                createdAt: createdAt,
                status: status,
              ),
      razorpay:
          (
            orderId,
            id,
            amount,
            amountDue,
            amountPaid,
            currency,
            createdAt,
            status,
          ) => PaymentInitiateEntity.razorpay(
            orderId: orderId,
            id: id,
            amount: amount,
            amountDue: amountDue,
            amountPaid: amountPaid,
            currency: currency,
            createdAt: createdAt,
            status: status,
          ),
      payu:
          (
            orderId,
            key,
            txnid,
            amount,
            hash,
            surl,
            furl,
            productInfo,
            firstName,
            email,
            phone,
          ) => PaymentInitiateEntity.payu(
            orderId: orderId,
            key: key,
            txnid: txnid,
            amount: amount,
            hash: hash,
            surl: surl,
            furl: furl,
            productInfo: productInfo,
            firstName: firstName,
            email: email,
            phone: phone,
          ),
    );
  }
}
