// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinDetailsModel _$PinDetailsModelFromJson(Map<String, dynamic> json) =>
    PinDetailsModel(
      city: json['city'] as String,
      state: json['state'] as String,
      location: json['location'] == null
          ? null
          : PinLocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PinDetailsModelToJson(PinDetailsModel instance) =>
    <String, dynamic>{
      'city': instance.city,
      'state': instance.state,
      'location': instance.location,
    };

PinLocationModel _$PinLocationModelFromJson(Map<String, dynamic> json) =>
    PinLocationModel(lat: json['lat'] as String, lng: json['lng'] as String);

Map<String, dynamic> _$PinLocationModelToJson(PinLocationModel instance) =>
    <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};
