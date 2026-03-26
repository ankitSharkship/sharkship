// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderStatusSummaryModel _$OrderStatusSummaryModelFromJson(
  Map<String, dynamic> json,
) => OrderStatusSummaryModel(
  toBeProcessedAndReadyToShip:
      (json['ToBeProcessedAndReadyToShipOrders'] as List<dynamic>)
          .map(
            (e) =>
                OrderStatusCountItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  otherOrders:
      (json['allOrdersExceptToBeProcessedAndReadyToShip'] as List<dynamic>)
          .map(
            (e) =>
                OrderStatusCountItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$OrderStatusSummaryModelToJson(
  OrderStatusSummaryModel instance,
) => <String, dynamic>{
  'ToBeProcessedAndReadyToShipOrders': instance.toBeProcessedAndReadyToShip
      .map((e) => e.toJson())
      .toList(),
  'allOrdersExceptToBeProcessedAndReadyToShip': instance.otherOrders
      .map((e) => e.toJson())
      .toList(),
};
