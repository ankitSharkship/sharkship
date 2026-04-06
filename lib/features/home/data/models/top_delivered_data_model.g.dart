// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_delivered_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopDeliveredDataModel _$TopDeliveredDataModelFromJson(
  Map<String, dynamic> json,
) => TopDeliveredDataModel(
  topDeliveredPincode: (json['topDeliveredPincode'] as List<dynamic>)
      .map(
        (e) => DeliveredPincodeCountModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
  topDeliveredCity: (json['topDeliveredCity'] as List<dynamic>)
      .map((e) => DeliveredCityCountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  topDeliveredState: (json['topDeliveredState'] as List<dynamic>)
      .map((e) => DeliveredStateCountModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  topDeliveredCourier: (json['topDeliveredCourier'] as List<dynamic>)
      .map(
        (e) => DeliveredCourierCountModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$TopDeliveredDataModelToJson(
  TopDeliveredDataModel instance,
) => <String, dynamic>{
  'topDeliveredPincode': instance.topDeliveredPincode
      .map((e) => e.toJson())
      .toList(),
  'topDeliveredCity': instance.topDeliveredCity.map((e) => e.toJson()).toList(),
  'topDeliveredState': instance.topDeliveredState
      .map((e) => e.toJson())
      .toList(),
  'topDeliveredCourier': instance.topDeliveredCourier
      .map((e) => e.toJson())
      .toList(),
};

DeliveredPincodeCountModel _$DeliveredPincodeCountModelFromJson(
  Map<String, dynamic> json,
) => DeliveredPincodeCountModel(
  pin: DeliveredPincodeCountModel._pinFromJson(json['pin']),
  count: DeliveredPincodeCountModel._countFromJson(json['count']),
  percentage: DeliveredPincodeCountModel._percentageFromJson(
    json['percentage'],
  ),
);

Map<String, dynamic> _$DeliveredPincodeCountModelToJson(
  DeliveredPincodeCountModel instance,
) => <String, dynamic>{
  'pin': instance.pin,
  'count': instance.count,
  'percentage': instance.percentage,
};

DeliveredCityCountModel _$DeliveredCityCountModelFromJson(
  Map<String, dynamic> json,
) => DeliveredCityCountModel(
  city: json['city'] as String,
  count: DeliveredCityCountModel._countFromJson(json['count']),
  percentage: DeliveredCityCountModel._percentageFromJson(json['percentage']),
);

Map<String, dynamic> _$DeliveredCityCountModelToJson(
  DeliveredCityCountModel instance,
) => <String, dynamic>{
  'city': instance.city,
  'count': instance.count,
  'percentage': instance.percentage,
};

DeliveredStateCountModel _$DeliveredStateCountModelFromJson(
  Map<String, dynamic> json,
) => DeliveredStateCountModel(
  state: json['state'] as String,
  count: DeliveredStateCountModel._countFromJson(json['count']),
  percentage: DeliveredStateCountModel._percentageFromJson(json['percentage']),
);

Map<String, dynamic> _$DeliveredStateCountModelToJson(
  DeliveredStateCountModel instance,
) => <String, dynamic>{
  'state': instance.state,
  'count': instance.count,
  'percentage': instance.percentage,
};

DeliveredCourierCountModel _$DeliveredCourierCountModelFromJson(
  Map<String, dynamic> json,
) => DeliveredCourierCountModel(
  carrier: json['carrier'] as String,
  count: DeliveredCourierCountModel._countFromJson(json['count']),
  percentage: DeliveredCourierCountModel._percentageFromJson(
    json['percentage'],
  ),
);

Map<String, dynamic> _$DeliveredCourierCountModelToJson(
  DeliveredCourierCountModel instance,
) => <String, dynamic>{
  'carrier': instance.carrier,
  'count': instance.count,
  'percentage': instance.percentage,
};
