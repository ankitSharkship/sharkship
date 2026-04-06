import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/top_delivered_data.dart';

part 'top_delivered_data_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TopDeliveredDataModel extends TopDeliveredData {
  @override
  @JsonKey(name: 'topDeliveredPincode')
  final List<DeliveredPincodeCountModel> topDeliveredPincode;

  @override
  @JsonKey(name: 'topDeliveredCity')
  final List<DeliveredCityCountModel> topDeliveredCity;

  @override
  @JsonKey(name: 'topDeliveredState')
  final List<DeliveredStateCountModel> topDeliveredState;

  @override
  @JsonKey(name: 'topDeliveredCourier')
  final List<DeliveredCourierCountModel> topDeliveredCourier;

  const TopDeliveredDataModel({
    required this.topDeliveredPincode,
    required this.topDeliveredCity,
    required this.topDeliveredState,
    required this.topDeliveredCourier,
  }) : super(
          topDeliveredPincode: topDeliveredPincode,
          topDeliveredCity: topDeliveredCity,
          topDeliveredState: topDeliveredState,
          topDeliveredCourier: topDeliveredCourier,
        );

  factory TopDeliveredDataModel.fromJson(Map<String, dynamic> json) =>
      _$TopDeliveredDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopDeliveredDataModelToJson(this);
}

@JsonSerializable()
class DeliveredPincodeCountModel extends DeliveredPincodeCount {
  @override
  @JsonKey(name: 'pin', fromJson: _pinFromJson)
  final String pin;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const DeliveredPincodeCountModel({
    required this.pin,
    required this.count,
    required this.percentage,
  }) : super(
          pin: pin,
          count: count,
          percentage: percentage,
        );

  factory DeliveredPincodeCountModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveredPincodeCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveredPincodeCountModelToJson(this);

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
class DeliveredCityCountModel extends DeliveredCityCount {
  @override
  final String city;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const DeliveredCityCountModel({
    required this.city,
    required this.count,
    required this.percentage,
  }) : super(
          city: city,
          count: count,
          percentage: percentage,
        );

  factory DeliveredCityCountModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveredCityCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveredCityCountModelToJson(this);

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
class DeliveredStateCountModel extends DeliveredStateCount {
  @override
  final String state;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const DeliveredStateCountModel({
    required this.state,
    required this.count,
    required this.percentage,
  }) : super(
          state: state,
          count: count,
          percentage: percentage,
        );

  factory DeliveredStateCountModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveredStateCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveredStateCountModelToJson(this);

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
class DeliveredCourierCountModel extends DeliveredCourierCount {
  @override
  final String carrier;

  @override
  @JsonKey(name: 'count', fromJson: _countFromJson)
  final int count;

  @override
  @JsonKey(name: 'percentage', fromJson: _percentageFromJson)
  final double percentage;

  const DeliveredCourierCountModel({
    required this.carrier,
    required this.count,
    required this.percentage,
  }) : super(
          carrier: carrier,
          count: count,
          percentage: percentage,
        );

  factory DeliveredCourierCountModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveredCourierCountModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveredCourierCountModelToJson(this);

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
