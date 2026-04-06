import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ndr_data.dart';

part 'ndr_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NdrDataModel extends NdrData {
  @override
  @JsonKey(name: 'ndrDataByZone')
  final List<NdrZoneCountModel> ndrDataByZone;

  @override
  @JsonKey(name: 'ndrDataByCourier')
  final List<NdrCourierCountModel> ndrDataByCourier;

  const NdrDataModel({
    required this.ndrDataByZone,
    required this.ndrDataByCourier,
  }) : super(
          ndrDataByZone: ndrDataByZone,
          ndrDataByCourier: ndrDataByCourier,
        );


  factory NdrDataModel.fromJson(Map<String, dynamic> json) =>
      _$NdrDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$NdrDataModelToJson(this);
}

@JsonSerializable()
class NdrZoneCountModel extends NdrZoneCount {
  @override
  final String zone;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  const NdrZoneCountModel({
    required this.zone,
    required this.count,
  }) : super(
          zone: zone,
          count: count,
        );

  factory NdrZoneCountModel.fromJson(Map<String, dynamic> json) =>
      _$NdrZoneCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$NdrZoneCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}

@JsonSerializable()
class NdrCourierCountModel extends NdrCourierCount {
  @override
  final String carrier;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  const NdrCourierCountModel({
    required this.carrier,
    required this.count,
  }) : super(
          carrier: carrier,
          count: count,
        );

  factory NdrCourierCountModel.fromJson(Map<String, dynamic> json) =>
      _$NdrCourierCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$NdrCourierCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }
}
