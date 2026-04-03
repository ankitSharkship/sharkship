import 'package:dio/dio.dart';
import 'package:sharkship/features/home/data/models/ndr_status_summary_model.dart';
import 'package:sharkship/features/home/data/models/order_status_summary_model.dart';
import 'package:sharkship/features/home/data/models/pickup_models/carrier_pickup_summary_list_model.dart';
import '../models/today_metrics_model.dart';

abstract class DashboardRemoteDataSource {
  Future<TodayMetricsModel> getTodayMetrics();
  Future<OrderStatusSummaryModel> getOrderStatusSummary();
  Future<NdrStatusSummaryModel> getNdrStatusSummary();
  Future<CarrierPickupSummaryListModel> getCarrierPickupData(String day);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<TodayMetricsModel> getTodayMetrics() async {
    final response = await _dio.get('v1/dashboard/today_metrics');
    return TodayMetricsModel.fromJson(response.data);
  }

  @override
  Future<OrderStatusSummaryModel> getOrderStatusSummary() async {
    final response = await _dio.get(
      "/v1/dashboard/count_by_status?startDate=2026-03-10T00:00:00.000Z&endDate=2026-03-24T23:59:59.999Z",
    );
    return OrderStatusSummaryModel.fromJson(response.data);
  }

  @override
  Future<NdrStatusSummaryModel> getNdrStatusSummary() async {
    final response = await _dio.get(
      "/v1/dashboard/ndr_overview?startDate=2026-03-10T00:00:00.000Z&endDate=2026-03-24T23:59:59.999Z",
    );
    return NdrStatusSummaryModel.fromJson(response.data);
  }

  @override
  Future<CarrierPickupSummaryListModel> getCarrierPickupData(String day) async {
    final response = await _dio.get(
      "/v1/dashboard/carrier-pickup-data?date=$day",
    );
    return CarrierPickupSummaryListModel.fromJson(response.data);
  }
}
