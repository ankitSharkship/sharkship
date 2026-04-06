// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_rto_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopRtoDataModel _$TopRtoDataModelFromJson(Map<String, dynamic> json) =>
    TopRtoDataModel(
      topRtoPincode: (json['topRtoPincode'] as List<dynamic>)
          .map((e) => RtoPincodeCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topRtoCity: (json['topRtoCity'] as List<dynamic>)
          .map((e) => RtoCityCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topRtoState: (json['topRtoState'] as List<dynamic>)
          .map((e) => RtoStateCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      topRtoCourier: (json['topRtoCourier'] as List<dynamic>)
          .map((e) => RtoCourierCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopRtoDataModelToJson(TopRtoDataModel instance) =>
    <String, dynamic>{
      'topRtoPincode': instance.topRtoPincode.map((e) => e.toJson()).toList(),
      'topRtoCity': instance.topRtoCity.map((e) => e.toJson()).toList(),
      'topRtoState': instance.topRtoState.map((e) => e.toJson()).toList(),
      'topRtoCourier': instance.topRtoCourier.map((e) => e.toJson()).toList(),
    };

RtoPincodeCountModel _$RtoPincodeCountModelFromJson(
  Map<String, dynamic> json,
) => RtoPincodeCountModel(
  pin: RtoPincodeCountModel._pinFromJson(json['pin']),
  count: RtoPincodeCountModel._countFromJson(json['count']),
  percentage: RtoPincodeCountModel._percentageFromJson(json['percentage']),
);

Map<String, dynamic> _$RtoPincodeCountModelToJson(
  RtoPincodeCountModel instance,
) => <String, dynamic>{
  'pin': instance.pin,
  'count': instance.count,
  'percentage': instance.percentage,
};

RtoCityCountModel _$RtoCityCountModelFromJson(Map<String, dynamic> json) =>
    RtoCityCountModel(
      city: json['city'] as String,
      count: RtoCityCountModel._countFromJson(json['count']),
      percentage: RtoCityCountModel._percentageFromJson(json['percentage']),
    );

Map<String, dynamic> _$RtoCityCountModelToJson(RtoCityCountModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'count': instance.count,
      'percentage': instance.percentage,
    };

RtoStateCountModel _$RtoStateCountModelFromJson(Map<String, dynamic> json) =>
    RtoStateCountModel(
      state: json['state'] as String,
      count: RtoStateCountModel._countFromJson(json['count']),
      percentage: RtoStateCountModel._percentageFromJson(json['percentage']),
    );

Map<String, dynamic> _$RtoStateCountModelToJson(RtoStateCountModel instance) =>
    <String, dynamic>{
      'state': instance.state,
      'count': instance.count,
      'percentage': instance.percentage,
    };

RtoCourierCountModel _$RtoCourierCountModelFromJson(
  Map<String, dynamic> json,
) => RtoCourierCountModel(
  carrier: json['carrier'] as String,
  count: RtoCourierCountModel._countFromJson(json['count']),
  percentage: RtoCourierCountModel._percentageFromJson(json['percentage']),
);

Map<String, dynamic> _$RtoCourierCountModelToJson(
  RtoCourierCountModel instance,
) => <String, dynamic>{
  'carrier': instance.carrier,
  'count': instance.count,
  'percentage': instance.percentage,
};
