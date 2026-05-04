import '../../domain/entities/payment_initiate_entity.dart';

class PaymentInitiateModel extends PaymentInitiateEntity {
  const PaymentInitiateModel({
    required super.orderId,
    required super.amount,
    required super.amountDue,
    required super.amountPaid,
    required super.attempts,
    required super.createdAt,
    required super.currency,
    required super.entity,
    required super.id,
    required super.notes,
    super.offerId,
    required super.receipt,
    required super.status,
  });

  factory PaymentInitiateModel.fromJson(Map<String, dynamic> json) {
    return PaymentInitiateModel(
      orderId: json['orderId'] as String,
      amount: json['amount'] as int,
      amountDue: json['amount_due'] as int,
      amountPaid: json['amount_paid'] as int,
      attempts: json['attempts'] as int,
      createdAt: json['created_at'] as int,
      currency: json['currency'] as String,
      entity: json['entity'] as String,
      id: json['id'] as String,
      notes: json['notes'] as List<dynamic>,
      offerId: json['offer_id'] as String?,
      receipt: json['receipt'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'amount_due': amountDue,
      'amount_paid': amountPaid,
      'attempts': attempts,
      'created_at': createdAt,
      'currency': currency,
      'entity': entity,
      'id': id,
      'notes': notes,
      'offer_id': offerId,
      'receipt': receipt,
      'status': status,
    };
  }
}
