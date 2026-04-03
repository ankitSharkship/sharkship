import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/order_status_summary.dart';
import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import '../../domain/entities/today_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../datasources/dashboard_remote_datasource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TodayMetrics> getTodayMetrics() async {
    return await remoteDataSource.getTodayMetrics();
  }

  @override
  Future<OrderStatusSummary> getOrderStatusCount() async {
    return await remoteDataSource.getOrderStatusSummary();
  }

  @override
  Future<NdrStatusSummary> getNdrStatusCount() async {
    return await remoteDataSource.getNdrStatusSummary();
  }

  @override
  Future<CarrierPickupSummaryList> getCarrierPickupData(String day) async {
    return await remoteDataSource.getCarrierPickupData(day);
  }
}
