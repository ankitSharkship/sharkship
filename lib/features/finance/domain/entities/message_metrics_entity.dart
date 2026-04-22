class MessageMetricsEntity {
  final String? totalCount;
  final String? totalAmount;
  final String? processedCount;
  final String? processedTotalAmount;
  final String? shippedCount;
  final String? shippedTotalAmount;
  final String? ndrCount;
  final String? ndrTotalAmount;
  final String? outForDeliveryCount;
  final String? outForDeliveryTotalAmount;
  final String? returnedCount;
  final String? returnedTotalAmount;
  final String? deliveredCount;
  final String? deliveredTotalAmount;
  final String? manualCount;
  final String? manualTotalAmount;
  final String? channelCount;
  final String? channelTotalAmount;

  MessageMetricsEntity({
    this.totalCount,
    this.totalAmount,
    this.processedCount,
    this.processedTotalAmount,
    this.shippedCount,
    this.shippedTotalAmount,
    this.ndrCount,
    this.ndrTotalAmount,
    this.outForDeliveryCount,
    this.outForDeliveryTotalAmount,
    this.returnedCount,
    this.returnedTotalAmount,
    this.deliveredCount,
    this.deliveredTotalAmount,
    this.manualCount,
    this.manualTotalAmount,
    this.channelCount,
    this.channelTotalAmount,
  });
}
