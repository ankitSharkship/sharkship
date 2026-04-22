class TransactionEntity {
  final String id;
  final String description;
  final String affected;
  final DateTime createdAt;
  final String? journeyType;
  final bool isUpdated;
  final String? orderId;
  final String? remarks;
  final String type;
  final String amount;
  final String? trackingId;
  final String? paymentGateway;
  final String? couponCode;
  final String? cashbackAmount;
  final String? txnId;
  final String? status;

  TransactionEntity({
    required this.id,
    required this.description,
    required this.affected,
    required this.createdAt,
    this.journeyType,
    required this.isUpdated,
    this.orderId,
    this.remarks,
    required this.type,
    required this.amount,
    this.trackingId,
    this.paymentGateway,
    this.couponCode,
    this.cashbackAmount,
    this.txnId,
    this.status,
  });
}

class TransactionResponse {
  final int totalCount;
  final List<TransactionEntity> transactions;

  TransactionResponse({required this.totalCount, required this.transactions});
}
