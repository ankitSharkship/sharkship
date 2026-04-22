class MessageTransactionEntity {
  final String id;
  final int processedCount;
  final String processedTotalAmount;
  final int shippedCount;
  final String shippedTotalAmount;
  final int ndrCount;
  final String ndrTotalAmount;
  final int outForDeliveryCount;
  final String outForDeliveryTotalAmount;
  final int returnedCount;
  final String returnedTotalAmount;
  final int deliveredCount;
  final String deliveredTotalAmount;
  final int manualCount;
  final String manualTotalAmount;
  final int channelCount;
  final String channelTotalAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int orderId;
  final String userId;

  MessageTransactionEntity({
    required this.id,
    required this.processedCount,
    required this.processedTotalAmount,
    required this.shippedCount,
    required this.shippedTotalAmount,
    required this.ndrCount,
    required this.ndrTotalAmount,
    required this.outForDeliveryCount,
    required this.outForDeliveryTotalAmount,
    required this.returnedCount,
    required this.returnedTotalAmount,
    required this.deliveredCount,
    required this.deliveredTotalAmount,
    required this.manualCount,
    required this.manualTotalAmount,
    required this.channelCount,
    required this.channelTotalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.orderId,
    required this.userId,
  });
}

class MessageTransactionsResponse {
  final int totalCount;
  final List<MessageTransactionEntity> transactions;

  MessageTransactionsResponse({
    required this.totalCount,
    required this.transactions,
  });
}
