import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.id,
    required super.description,
    required super.affected,
    required super.createdAt,
    super.journeyType,
    required super.isUpdated,
    super.orderId,
    super.remarks,
    required super.type,
    required super.amount,
    super.trackingId,
    super.paymentGateway,
    super.cashbackAmount,
    super.couponCode,
    super.txnId,
    super.status
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      description: json['description'] as String,
      affected: json['affected'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      journeyType: json['journey_type'] as String?,
      isUpdated: json['is_updated'] as bool? ?? false,
      orderId: json['orderId']?.toString(),
      remarks: json['remarks'] as String?,
      type: json['type'] as String,
      amount: json['amount'] as String,
      trackingId: json['tracking_id']?.toString(),
      paymentGateway: json['paymentGateway']?.toString(),
      cashbackAmount: json['cashback_amt']?.toString(),
      txnId: json['txn_id']?.toString(),
      couponCode: json['coupon_code']?.toString(),
      status: json['status']?.toString()
    );
  }
}

class TransactionResponseModel extends TransactionResponse {
  TransactionResponseModel({
    required super.totalCount,
    required List<TransactionModel> transactions,
  }) : super(transactions: transactions);

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    return TransactionResponseModel(
      totalCount: json['totalCount'] as int,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
