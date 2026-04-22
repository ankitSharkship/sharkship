

import 'package:sharkship/features/finance/domain/entities/message_metrics_entity.dart';

class MessageMetricsModel extends MessageMetricsEntity {
  MessageMetricsModel({
    super.totalCount,
    super.totalAmount,
    super.processedCount,
    super.processedTotalAmount,
    super.shippedCount,
    super.shippedTotalAmount,
    super.ndrCount,
    super.ndrTotalAmount,
    super.outForDeliveryCount,
    super.outForDeliveryTotalAmount,
    super.returnedCount,
    super.returnedTotalAmount,
    super.deliveredCount,
    super.deliveredTotalAmount,
    super.manualCount,
    super.manualTotalAmount,
    super.channelCount,
    super.channelTotalAmount,
  });

  factory MessageMetricsModel.fromJson(Map<String, dynamic> json) {
    return MessageMetricsModel(
      totalCount: json['total_count']?.toString(),
      totalAmount: json['total_amount']?.toString(),
      processedCount: json['processed_count']?.toString(),
      processedTotalAmount: json['processed_total_amount']?.toString(),
      shippedCount: json['shipped_count']?.toString(),
      shippedTotalAmount: json['shipped_total_amount']?.toString(),
      ndrCount: json['ndr_count']?.toString(),
      ndrTotalAmount: json['ndr_total_amount']?.toString(),
      outForDeliveryCount: json['out_for_delivery_count']?.toString(),
      outForDeliveryTotalAmount: json['out_for_delivery_total_amount']?.toString(),
      returnedCount: json['returned_count']?.toString(),
      returnedTotalAmount: json['returned_total_amount']?.toString(),
      deliveredCount: json['delivered_count']?.toString(),
      deliveredTotalAmount: json['delivered_total_amount']?.toString(),
      manualCount: json['manual_count']?.toString(),
      manualTotalAmount: json['manual_total_amount']?.toString(),
      channelCount: json['channel_count']?.toString(),
      channelTotalAmount: json['channel_total_amount']?.toString(),
    );
  }
}
