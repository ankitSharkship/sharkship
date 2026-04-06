import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import '../entities/datewise_ndr_count.dart';
import '../entities/ndr_data.dart';
import '../entities/today_metrics.dart';

abstract class DashboardRepository {
  Future<TodayMetrics> getTodayMetrics({DateTime? startDate, DateTime? endDate});
  Future<OrderStatusSummary> getOrderStatusCount({DateTime? startDate, DateTime? endDate});
  Future<NdrStatusSummary> getNdrStatusCount({DateTime? startDate, DateTime? endDate});
  Future<CarrierPickupSummaryList> getCarrierPickupData(String day, {DateTime? startDate, DateTime? endDate});
  Future<NdrData> getNdrData({DateTime? startDate, DateTime? endDate});
  Future<List<DatewiseNdrCount>> getDatewiseNdrCount({DateTime? startDate, DateTime? endDate});
}
