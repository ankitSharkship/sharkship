// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_status_count_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NdrStatusCountItemModel _$NdrStatusCountItemModelFromJson(
  Map<String, dynamic> json,
) => NdrStatusCountItemModel(
  isNdr: json['isNdr'] as bool,
  count: json['count'] as String,
);

Map<String, dynamic> _$NdrStatusCountItemModelToJson(
  NdrStatusCountItemModel instance,
) => <String, dynamic>{'isNdr': instance.isNdr, 'count': instance.count};
