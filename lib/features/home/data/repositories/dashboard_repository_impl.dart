import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import '../../domain/entities/datewise_ndr_count.dart';
import '../../domain/entities/ndr_data.dart';
import '../../domain/entities/today_metrics.dart';
import '../../domain/entities/top_rto_data.dart';
import '../../domain/entities/datewise_rto_count.dart';
import '../../domain/entities/top_delivered_data.dart';
import '../../domain/entities/cod_data.dart';
import '../../domain/entities/order_revenue.dart';
import '../../domain/entities/remittance_overview.dart';
import '../../domain/entities/business_entities.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TodayMetrics> getTodayMetrics({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getTodayMetrics(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<OrderStatusSummary> getOrderStatusCount({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getOrderStatusSummary(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<NdrStatusSummary> getNdrStatusCount({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getNdrStatusSummary(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<CarrierPickupSummaryList> getCarrierPickupData(
    String day) async {
    return await remoteDataSource.getCarrierPickupData(day);
  }

  @override
  Future<NdrData> getNdrData({DateTime? startDate, DateTime? endDate}) async {
    return await remoteDataSource.getNdrData(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<DatewiseNdrCount>> getDatewiseNdrCount({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getDatewiseNdrCount(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<TopRtoData> getTopRtoData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getTopRtoData(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<DatewiseRtoCount>> getDatewiseRtoCount({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getDatewiseRtoCount(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<TopDeliveredData> getTopDeliveredData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getTopDeliveredData(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<CodData>> getCodData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getCodData(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<OrderRevenue> getOrderRevenue({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getOrderRevenue(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<RemittanceOverview> getRemittanceOverview() async {
    return await remoteDataSource.getRemittanceOverview();
  }

  @override
  Future<List<BusinessOverviewCount>> getBusinessOverview({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getBusinessOverview(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<StateStatusCount>> getMapOrders({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getMapOrders(
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<ZonePercentageCount>> getZoneDistribution({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await remoteDataSource.getZoneDistribution(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
