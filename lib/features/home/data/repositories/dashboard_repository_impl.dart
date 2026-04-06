import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import '../../domain/entities/datewise_ndr_count.dart';
import '../../domain/entities/ndr_data.dart';
import '../../domain/entities/today_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TodayMetrics> getTodayMetrics({DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getTodayMetrics(startDate: startDate, endDate: endDate);
  }

  @override
  Future<OrderStatusSummary> getOrderStatusCount({DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getOrderStatusSummary(startDate: startDate, endDate: endDate);
  }

  @override
  Future<NdrStatusSummary> getNdrStatusCount({DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getNdrStatusSummary(startDate: startDate, endDate: endDate);
  }

  @override
  Future<CarrierPickupSummaryList> getCarrierPickupData(String day, {DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getCarrierPickupData(day, startDate: startDate, endDate: endDate);
  }

  @override
  Future<NdrData> getNdrData({DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getNdrData(startDate: startDate, endDate: endDate);
  }

  @override
  Future<List<DatewiseNdrCount>> getDatewiseNdrCount({DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getDatewiseNdrCount(startDate: startDate, endDate: endDate);
  }
}
