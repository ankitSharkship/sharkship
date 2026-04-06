import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import '../entities/datewise_ndr_count.dart';
import '../entities/ndr_data.dart';
import '../entities/today_metrics.dart';
import '../entities/top_rto_data.dart';
import '../entities/datewise_rto_count.dart';
import '../entities/top_delivered_data.dart';
import '../entities/cod_data.dart';
import '../entities/order_revenue.dart';

abstract class DashboardRepository {
  Future<TodayMetrics> getTodayMetrics({DateTime? startDate, DateTime? endDate});
  Future<OrderStatusSummary> getOrderStatusCount(
      {DateTime? startDate, DateTime? endDate});
  Future<NdrStatusSummary> getNdrStatusCount(
      {DateTime? startDate, DateTime? endDate});
  Future<CarrierPickupSummaryList> getCarrierPickupData(String day,
      {DateTime? startDate, DateTime? endDate});
  Future<NdrData> getNdrData({DateTime? startDate, DateTime? endDate});
  Future<List<DatewiseNdrCount>> getDatewiseNdrCount(
      {DateTime? startDate, DateTime? endDate});
  Future<TopRtoData> getTopRtoData({DateTime? startDate, DateTime? endDate});
  Future<List<DatewiseRtoCount>> getDatewiseRtoCount(
      {DateTime? startDate, DateTime? endDate});
  Future<TopDeliveredData> getTopDeliveredData(
      {DateTime? startDate, DateTime? endDate});
  Future<List<CodData>> getCodData({DateTime? startDate, DateTime? endDate});
  Future<OrderRevenue> getOrderRevenue({DateTime? startDate, DateTime? endDate});
}
