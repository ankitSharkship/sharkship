// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ndr_status_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NdrStatusSummaryModel _$NdrStatusSummaryModelFromJson(
  Map<String, dynamic> json,
) => NdrStatusSummaryModel(
  countByNDRStatus: (json['countByNDRStatus'] as List<dynamic>)
      .map((e) => NdrStatusGroupModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$NdrStatusSummaryModelToJson(
  NdrStatusSummaryModel instance,
) => <String, dynamic>{
  'countByNDRStatus': instance.countByNDRStatus.map((e) => e.toJson()).toList(),
};
