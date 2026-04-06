import 'package:equatable/equatable.dart';

class OrderRevenue extends Equatable {
  final num todayRevenue;
  final int todayOrderCount;
  final num yesterdayRevenue;
  final int yesterdayOrderCount;
  final int totalDeliveredOrders;
  final List<CourierRevenue> courierRevenues;
  final num totalRevenue;

  const OrderRevenue({
    required this.todayRevenue,
    required this.todayOrderCount,
    required this.yesterdayRevenue,
    required this.yesterdayOrderCount,
    required this.totalDeliveredOrders,
    required this.courierRevenues,
    required this.totalRevenue,
  });

  double get orderCountPercentageIncrease {
    if (yesterdayOrderCount == 0) {
      return todayOrderCount > 0 ? 100.0 : 0.0;
    }
    return ((todayOrderCount - yesterdayOrderCount) / yesterdayOrderCount) * 100;
  }

  double get revenuePercentageIncrease {
    if (yesterdayRevenue == 0) {
      return todayRevenue > 0 ? 100.0 : 0.0;
    }
    return ((todayRevenue - yesterdayRevenue) / yesterdayRevenue) * 100;
  }

  @override
  List<Object?> get props => [
        todayRevenue,
        todayOrderCount,
        yesterdayRevenue,
        yesterdayOrderCount,
        totalDeliveredOrders,
        courierRevenues,
        totalRevenue,
      ];
}

class CourierRevenue extends Equatable {
  final String carrierName;
  final int numberOfOrders;
  final int prepaidOrders;
  final num revenuePrepaid;
  final int codOrders;
  final num revenueCod;
  final num totalRevenue;

  const CourierRevenue({
    required this.carrierName,
    required this.numberOfOrders,
    required this.prepaidOrders,
    required this.revenuePrepaid,
    required this.codOrders,
    required this.revenueCod,
    required this.totalRevenue,
  });

  @override
  List<Object?> get props => [
        carrierName,
        numberOfOrders,
        prepaidOrders,
        revenuePrepaid,
        codOrders,
        revenueCod,
        totalRevenue,
      ];
}
