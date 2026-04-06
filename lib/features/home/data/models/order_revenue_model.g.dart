// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_revenue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRevenueModel _$OrderRevenueModelFromJson(Map<String, dynamic> json) =>
    OrderRevenueModel(
      todayRevenue: OrderRevenueModel._numFromJson(json['todayRevenue']),
      todayOrderCount: OrderRevenueModel._intFromJson(json['todayOrderCount']),
      yesterdayRevenue: OrderRevenueModel._numFromJson(
        json['yesterdayRevenue'],
      ),
      yesterdayOrderCount: OrderRevenueModel._intFromJson(
        json['yesterdayOrderCount'],
      ),
      totalDeliveredOrders: OrderRevenueModel._intFromJson(
        json['totalDeliveredOrders'],
      ),
      courierRevenues: (json['courierRevenues'] as List<dynamic>)
          .map((e) => CourierRevenueModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalRevenue: OrderRevenueModel._numFromJson(json['totalRevenue']),
    );

Map<String, dynamic> _$OrderRevenueModelToJson(
  OrderRevenueModel instance,
) => <String, dynamic>{
  'todayRevenue': instance.todayRevenue,
  'todayOrderCount': instance.todayOrderCount,
  'yesterdayRevenue': instance.yesterdayRevenue,
  'yesterdayOrderCount': instance.yesterdayOrderCount,
  'totalDeliveredOrders': instance.totalDeliveredOrders,
  'courierRevenues': instance.courierRevenues.map((e) => e.toJson()).toList(),
  'totalRevenue': instance.totalRevenue,
};

CourierRevenueModel _$CourierRevenueModelFromJson(Map<String, dynamic> json) =>
    CourierRevenueModel(
      carrierName: json['carrierName'] as String,
      numberOfOrders: CourierRevenueModel._intFromJson(json['numberOfOrders']),
      prepaidOrders: CourierRevenueModel._intFromJson(json['prepaid_orders']),
      revenuePrepaid: CourierRevenueModel._numFromJson(json['revenue_prepaid']),
      codOrders: CourierRevenueModel._intFromJson(json['cod_orders']),
      revenueCod: CourierRevenueModel._numFromJson(json['revenue_cod']),
      totalRevenue: CourierRevenueModel._numFromJson(json['total_revenue']),
    );

Map<String, dynamic> _$CourierRevenueModelToJson(
  CourierRevenueModel instance,
) => <String, dynamic>{
  'carrierName': instance.carrierName,
  'numberOfOrders': instance.numberOfOrders,
  'prepaid_orders': instance.prepaidOrders,
  'revenue_prepaid': instance.revenuePrepaid,
  'cod_orders': instance.codOrders,
  'revenue_cod': instance.revenueCod,
  'total_revenue': instance.totalRevenue,
};
