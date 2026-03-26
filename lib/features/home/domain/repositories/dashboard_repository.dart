import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import '../entities/today_metrics.dart';

abstract class DashboardRepository {
  Future<TodayMetrics> getTodayMetrics();
  Future<OrderStatusSummary> getOrderStatusCount();
  Future<NdrStatusSummary> getNdrStatusCount();
}
