import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/top_rto_data.dart';

part 'top_rto_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TopRtoDataModel extends TopRtoData {
  @override
  @JsonKey(name: 'topRtoPincode')
  final List<RtoPincodeCountModel> topRtoPincode;

  @override
  @JsonKey(name: 'topRtoCity')
  final List<RtoCityCountModel> topRtoCity;

  @override
  @JsonKey(name: 'topRtoState')
  final List<RtoStateCountModel> topRtoState;

  @override
  @JsonKey(name: 'topRtoCourier')
  final List<RtoCourierCountModel> topRtoCourier;

  const TopRtoDataModel({
    required this.topRtoPincode,
    required this.topRtoCity,
    required this.topRtoState,
    required this.topRtoCourier,
  }) : super(
          topRtoPincode: topRtoPincode,
          topRtoCity: topRtoCity,
          topRtoState: topRtoState,
          topRtoCourier: topRtoCourier,
        );

  factory TopRtoDataModel.fromJson(Map<String, dynamic> json) =>
      _$TopRtoDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopRtoDataModelToJson(this);
}

@JsonSerializable()
class RtoPincodeCountModel extends RtoPincodeCount {
  @override
  @JsonKey(name: 'pin', fromJson: _pinFromJson)
  final String pin;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const RtoPincodeCountModel({
    required this.pin,
    required this.count,
    required this.percentage,
  }) : super(
          pin: pin,
          count: count,
          percentage: percentage,
        );

  factory RtoPincodeCountModel.fromJson(Map<String, dynamic> json) =>
      _$RtoPincodeCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$RtoPincodeCountModelToJson(this);

  static String _pinFromJson(dynamic value) => value.toString();

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }
}

@JsonSerializable()
class RtoCityCountModel extends RtoCityCount {
  @override
  final String city;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const RtoCityCountModel({
    required this.city,
    required this.count,
    required this.percentage,
  }) : super(
          city: city,
          count: count,
          percentage: percentage,
        );

  factory RtoCityCountModel.fromJson(Map<String, dynamic> json) =>
      _$RtoCityCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$RtoCityCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }
}

@JsonSerializable()
class RtoStateCountModel extends RtoStateCount {
  @override
  final String state;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const RtoStateCountModel({
    required this.state,
    required this.count,
    required this.percentage,
  }) : super(
          state: state,
          count: count,
          percentage: percentage,
        );

  factory RtoStateCountModel.fromJson(Map<String, dynamic> json) =>
      _$RtoStateCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$RtoStateCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }
}

@JsonSerializable()
class RtoCourierCountModel extends RtoCourierCount {
  @override
  final String carrier;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const RtoCourierCountModel({
    required this.carrier,
    required this.count,
    required this.percentage,
  }) : super(
          carrier: carrier,
          count: count,
          percentage: percentage,
        );

  factory RtoCourierCountModel.fromJson(Map<String, dynamic> json) =>
      _$RtoCourierCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$RtoCourierCountModelToJson(this);

  static int _countFromJson(dynamic value) {
    if (value is String) return int.tryParse(value) ?? 0;
    if (value is num) return value.toInt();
    return 0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value is String) return double.tryParse(value) ?? 0.0;
    if (value is num) return value.toDouble();
    return 0.0;
  }
}
