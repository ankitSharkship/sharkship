import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/order_revenue.dart';

part 'order_revenue_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderRevenueModel extends OrderRevenue {
  @override
  @JsonKey(name: 'todayRevenue', fromJson: _numFromJson)
  final num todayRevenue;

  @override
  @JsonKey(name: 'todayOrderCount', fromJson: _intFromJson)
  final int todayOrderCount;

  @override
  @JsonKey(name: 'yesterdayRevenue', fromJson: _numFromJson)
  final num yesterdayRevenue;

  @override
  @JsonKey(name: 'yesterdayOrderCount', fromJson: _intFromJson)
  final int yesterdayOrderCount;

  @override
  @JsonKey(name: 'totalDeliveredOrders', fromJson: _intFromJson)
  final int totalDeliveredOrders;

  @override
  @JsonKey(name: 'courierRevenues')
  final List<CourierRevenueModel> courierRevenues;

  @override
  @JsonKey(name: 'totalRevenue', fromJson: _numFromJson)
  final num totalRevenue;

  const OrderRevenueModel({
    required this.todayRevenue,
    required this.todayOrderCount,
    required this.yesterdayRevenue,
    required this.yesterdayOrderCount,
    required this.totalDeliveredOrders,
    required this.courierRevenues,
    required this.totalRevenue,
  }) : super(
          todayRevenue: todayRevenue,
          todayOrderCount: todayOrderCount,
          yesterdayRevenue: yesterdayRevenue,
          yesterdayOrderCount: yesterdayOrderCount,
          totalDeliveredOrders: totalDeliveredOrders,
          courierRevenues: courierRevenues,
          totalRevenue: totalRevenue,
        );

  factory OrderRevenueModel.fromJson(Map<String, dynamic> json) =>
      _$OrderRevenueModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRevenueModelToJson(this);

  static num _numFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? 0;
    return 0;
  }

  static int _intFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}

@JsonSerializable()
class CourierRevenueModel extends CourierRevenue {
  @override
  @JsonKey(name: 'numberOfOrders', fromJson: _intFromJson)
  final int numberOfOrders;

  @override
  @JsonKey(name: 'prepaid_orders', fromJson: _intFromJson)
  final int prepaidOrders;

  @override
  @JsonKey(name: 'revenue_prepaid', fromJson: _numFromJson)
  final num revenuePrepaid;

  @override
  @JsonKey(name: 'cod_orders', fromJson: _intFromJson)
  final int codOrders;

  @override
  @JsonKey(name: 'revenue_cod', fromJson: _numFromJson)
  final num revenueCod;

  @override
  @JsonKey(name: 'total_revenue', fromJson: _numFromJson)
  final num totalRevenue;

  const CourierRevenueModel({
    required super.carrierName,
    required this.numberOfOrders,
    required this.prepaidOrders,
    required this.revenuePrepaid,
    required this.codOrders,
    required this.revenueCod,
    required this.totalRevenue,
  }) : super(
          numberOfOrders: numberOfOrders,
          prepaidOrders: prepaidOrders,
          revenuePrepaid: revenuePrepaid,
          codOrders: codOrders,
          revenueCod: revenueCod,
          totalRevenue: totalRevenue,
        );

  factory CourierRevenueModel.fromJson(Map<String, dynamic> json) =>
      _$CourierRevenueModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourierRevenueModelToJson(this);

  static num _numFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? 0;
    return 0;
  }

  static int _intFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
