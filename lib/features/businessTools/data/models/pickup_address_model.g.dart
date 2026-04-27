// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickupAddressModel _$PickupAddressModelFromJson(
  Map<String, dynamic> json,
) => PickupAddressModel(
  id: (json['id'] as num?)?.toInt(),
  addressLane1: json['address_lane1'] as String,
  addressLane2: json['address_lane2'] as String,
  landmark: json['landmark'] as String,
  pin: json['Pin'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  name: json['name'] as String,
  phoneNo: json['phone_no'] as String,
  delhiverySurfaceAddressId: json['delhivery_surface_address_id'] as String?,
  delhiveryExpressAddressId: json['delhivery_express_address_id'] as String?,
  delhiveryIntegration2kgAddressId:
      json['delhivery_integration_2kg_address_id'] as String?,
  delhiveryIntegration5kgAddressId:
      json['delhivery_integration_5kg_address_id'] as String?,
  delhiveryIntegration10kgAddressId:
      json['delhivery_integration_10kg_address_id'] as String?,
  delhiveryIntegration20kgAddressId:
      json['delhivery_integration_20kg_address_id'] as String?,
  blueDartSurfaceAddressId: json['blueDart_surface_address_id'] as String?,
  blueDartExpressAddressId: json['blueDart_express_address_id'] as String?,
  shadowfaxSurfaceAddressId: json['shadowfax_surface_address_id'] as String?,
  dtdcSurfaceAddressId: json['dtdc_surface_address_id'] as String?,
  dtdcExpressAddressId: json['dtdc_express_address_id'] as String?,
  expressflyAddressId: json['expressfly_address_id'] as String?,
  shiprocketAddressId: json['shiprocket_address_id'] as String?,
  blitzAddressId: json['blitz_address_id'] as String?,
  isDefault: json['default'] as String?,
  hidden: json['hidden'] as String?,
  user: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PickupAddressModelToJson(PickupAddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'landmark': instance.landmark,
      'city': instance.city,
      'state': instance.state,
      'name': instance.name,
      'hidden': instance.hidden,
      'address_lane1': instance.addressLane1,
      'address_lane2': instance.addressLane2,
      'Pin': instance.pin,
      'phone_no': instance.phoneNo,
      'delhivery_surface_address_id': instance.delhiverySurfaceAddressId,
      'delhivery_express_address_id': instance.delhiveryExpressAddressId,
      'delhivery_integration_2kg_address_id':
          instance.delhiveryIntegration2kgAddressId,
      'delhivery_integration_5kg_address_id':
          instance.delhiveryIntegration5kgAddressId,
      'delhivery_integration_10kg_address_id':
          instance.delhiveryIntegration10kgAddressId,
      'delhivery_integration_20kg_address_id':
          instance.delhiveryIntegration20kgAddressId,
      'blueDart_surface_address_id': instance.blueDartSurfaceAddressId,
      'blueDart_express_address_id': instance.blueDartExpressAddressId,
      'shadowfax_surface_address_id': instance.shadowfaxSurfaceAddressId,
      'dtdc_surface_address_id': instance.dtdcSurfaceAddressId,
      'dtdc_express_address_id': instance.dtdcExpressAddressId,
      'expressfly_address_id': instance.expressflyAddressId,
      'shiprocket_address_id': instance.shiprocketAddressId,
      'blitz_address_id': instance.blitzAddressId,
      'default': instance.isDefault,
      'user': instance.user?.toJson(),
    };
