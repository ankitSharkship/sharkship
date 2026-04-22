import 'package:sharkship/features/finance/domain/entities/message_transaction_entity.dart';



class MessageTransactionModel extends MessageTransactionEntity {
  MessageTransactionModel({
    required super.id,
    required super.processedCount,
    required super.processedTotalAmount,
    required super.shippedCount,
    required super.shippedTotalAmount,
    required super.ndrCount,
    required super.ndrTotalAmount,
    required super.outForDeliveryCount,
    required super.outForDeliveryTotalAmount,
    required super.returnedCount,
    required super.returnedTotalAmount,
    required super.deliveredCount,
    required super.deliveredTotalAmount,
    required super.manualCount,
    required super.manualTotalAmount,
    required super.channelCount,
    required super.channelTotalAmount,
    required super.createdAt,
    required super.updatedAt,
    required super.orderId,
    required super.userId,
  });

  factory MessageTransactionModel.fromJson(Map<String, dynamic> json) {
    return MessageTransactionModel(
      id: json['transaction_id'] as String,
      processedCount: json['transaction_processed_count'] as int,
      processedTotalAmount: json['transaction_processed_total_amount'] as String,
      shippedCount: json['transaction_shipped_count'] as int,
      shippedTotalAmount: json['transaction_shipped_total_amount'] as String,
      ndrCount: json['transaction_ndr_count'] as int,
      ndrTotalAmount: json['transaction_ndr_total_amount'] as String,
      outForDeliveryCount: json['transaction_out_for_delivery_count'] as int,
      outForDeliveryTotalAmount: json['transaction_out_for_delivery_total_amount'] as String,
      returnedCount: json['transaction_returned_count'] as int,
      returnedTotalAmount: json['transaction_returned_total_amount'] as String,
      deliveredCount: json['transaction_delivered_count'] as int,
      deliveredTotalAmount: json['transaction_delivered_total_amount'] as String,
      manualCount: json['transaction_manual_count'] as int,
      manualTotalAmount: json['transaction_manual_total_amount'] as String,
      channelCount: json['transaction_channel_count'] as int,
      channelTotalAmount: json['transaction_channel_total_amount'] as String,
      createdAt: DateTime.parse(json['transaction_created_at'] as String),
      updatedAt: DateTime.parse(json['transaction_updated_at'] as String),
      orderId: json['transaction_orderId'] as int,
      userId: json['transaction_userId'] as String,
    );
  }
}

class MessageTransactionsResponseModel extends MessageTransactionsResponse {
  MessageTransactionsResponseModel({
    required super.totalCount,
    required List<MessageTransactionModel> transactions,
  }) : super(transactions: transactions);

  factory MessageTransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageTransactionsResponseModel(
      totalCount: json['totalCount'] as int,
      transactions: (json['transaction'] as List<dynamic>)
          .map((e) => MessageTransactionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
