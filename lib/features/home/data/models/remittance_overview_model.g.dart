// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remittance_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemittanceOverviewResponseModel _$RemittanceOverviewResponseModelFromJson(
  Map<String, dynamic> json,
) => RemittanceOverviewResponseModel(
  remittanceDetails: RemittanceOverviewModel.fromJson(
    json['remittanceDetails'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$RemittanceOverviewResponseModelToJson(
  RemittanceOverviewResponseModel instance,
) => <String, dynamic>{
  'remittanceDetails': instance.remittanceDetails.toJson(),
};

RemittanceOverviewModel _$RemittanceOverviewModelFromJson(
  Map<String, dynamic> json,
) => RemittanceOverviewModel(
  totalRemittancePaid: RemittanceOverviewModel._numFromJson(
    json['total_remittance_paid'],
  ),
  totalCodCollected: RemittanceOverviewModel._numFromJson(
    json['total_cod_collected'],
  ),
  upcomingRemittance: RemittanceOverviewModel._numFromJson(
    json['upcoming_remittance'],
  ),
  dueRemittance: RemittanceOverviewModel._numFromJson(json['due_remittance']),
);

Map<String, dynamic> _$RemittanceOverviewModelToJson(
  RemittanceOverviewModel instance,
) => <String, dynamic>{
  'total_remittance_paid': instance.totalRemittancePaid,
  'total_cod_collected': instance.totalCodCollected,
  'upcoming_remittance': instance.upcomingRemittance,
  'due_remittance': instance.dueRemittance,
};
