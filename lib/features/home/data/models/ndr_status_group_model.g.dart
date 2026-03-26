// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_status_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NdrStatusGroupModel _$NdrStatusGroupModelFromJson(
  Map<String, dynamic> json,
) => NdrStatusGroupModel(
  ndrOrders: (json['NDRorders'] as List<dynamic>)
      .map((e) => NdrStatusCountItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  reattemptOrders: (json['reattemptOrders'] as List<dynamic>)
      .map((e) => NdrStatusCountItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  deliveredOrders: (json['deliveredOrders'] as List<dynamic>)
      .map((e) => NdrStatusCountItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  returnedOrders: (json['returnedOrders'] as List<dynamic>)
      .map((e) => NdrStatusCountItemModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NdrStatusGroupModelToJson(
  NdrStatusGroupModel instance,
) => <String, dynamic>{
  'NDRorders': instance.ndrOrders.map((e) => e.toJson()).toList(),
  'reattemptOrders': instance.reattemptOrders.map((e) => e.toJson()).toList(),
  'deliveredOrders': instance.deliveredOrders.map((e) => e.toJson()).toList(),
  'returnedOrders': instance.returnedOrders.map((e) => e.toJson()).toList(),
};
