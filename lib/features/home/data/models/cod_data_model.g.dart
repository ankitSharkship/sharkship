// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cod_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodDataModel _$CodDataModelFromJson(Map<String, dynamic> json) => CodDataModel(
  date: DateTime.parse(json['date'] as String),
  codCollection: CodDataModel._collectionFromJson(json['codCollection']),
  codOrderCount: CodDataModel._countFromJson(json['codOrderCount']),
);

Map<String, dynamic> _$CodDataModelToJson(CodDataModel instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'codCollection': instance.codCollection,
      'codOrderCount': instance.codOrderCount,
    };
