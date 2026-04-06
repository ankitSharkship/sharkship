import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cod_data.dart';

part 'cod_data_model.g.dart';

@JsonSerializable()
class CodDataModel extends CodData {
  @override
  final DateTime date;

  @override
  @JsonKey(name: 'codCollection', fromJson: _collectionFromJson)
  final String codCollection;

  @override
  @JsonKey(name: 'codOrderCount', fromJson: _countFromJson)
  final int codOrderCount;

  const CodDataModel({
    required this.date,
    required this.codCollection,
    required this.codOrderCount,
  }) : super(
          date: date,
          codCollection: codCollection,
          codOrderCount: codOrderCount,
        );

  factory CodDataModel.fromJson(Map<String, dynamic> json) =>
      _$CodDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$CodDataModelToJson(this);

  static String _collectionFromJson(dynamic value) => value.toString();

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}
