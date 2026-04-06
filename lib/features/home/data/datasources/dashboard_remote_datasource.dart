import 'package:dio/dio.dart';
import 'package:sharkship/features/home/data/models/ndr_status_summary_model.dart';
import 'package:sharkship/features/home/data/models/order_status_summary_model.dart';
import 'package:sharkship/features/home/data/models/pickup_models/carrier_pickup_summary_list_model.dart';
import '../models/ndr_data_model.dart';
import '../models/datewise_ndr_count_model.dart';
import '../models/today_metrics_model.dart';

abstract class DashboardRemoteDataSource {
  Future<TodayMetricsModel> getTodayMetrics({DateTime? startDate, DateTime? endDate});
  Future<OrderStatusSummaryModel> getOrderStatusSummary({DateTime? startDate, DateTime? endDate});
  Future<NdrStatusSummaryModel> getNdrStatusSummary({DateTime? startDate, DateTime? endDate});
  Future<CarrierPickupSummaryListModel> getCarrierPickupData(String day, {DateTime? startDate, DateTime? endDate});
  Future<NdrDataModel> getNdrData({DateTime? startDate, DateTime? endDate});
  Future<List<DatewiseNdrCountModel>> getDatewiseNdrCount({DateTime? startDate, DateTime? endDate});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  String _formatDate(DateTime date, bool isStart) {
    if (isStart) {
      return "${date.toIso8601String().split('T')[0]}T00:00:00.000Z";
    } else {
      return "${date.toIso8601String().split('T')[0]}T23:59:59.999Z";
    }
  }

  @override
  Future<TodayMetricsModel> getTodayMetrics({DateTime? startDate, DateTime? endDate}) async {
    String path = 'v1/dashboard/today_metrics';
    if (startDate != null && endDate != null) {
      path += "?startDate=${_formatDate(startDate, true)}&endDate=${_formatDate(endDate, false)}";
    }
    final response = await _dio.get(path);
    return TodayMetricsModel.fromJson(response.data);
  }

  @override
  Future<OrderStatusSummaryModel> getOrderStatusSummary({DateTime? startDate, DateTime? endDate}) async {
    String query = "";
    if (startDate != null && endDate != null) {
      query = "?startDate=${_formatDate(startDate, true)}&endDate=${_formatDate(endDate, false)}";
    } else {
      query = "?startDate=2026-03-10T00:00:00.000Z&endDate=2026-03-24T23:59:59.999Z";
    }
    final response = await _dio.get("/v1/dashboard/count_by_status$query");
    return OrderStatusSummaryModel.fromJson(response.data);
  }

  @override
  Future<NdrStatusSummaryModel> getNdrStatusSummary({DateTime? startDate, DateTime? endDate}) async {
    String query = "";
    if (startDate != null && endDate != null) {
      query = "?startDate=${_formatDate(startDate, true)}&endDate=${_formatDate(endDate, false)}";
    } else {
      query = "?startDate=2026-03-10T00:00:00.000Z&endDate=2026-03-24T23:59:59.999Z";
    }
    final response = await _dio.get("/v1/dashboard/ndr_overview$query");
    return NdrStatusSummaryModel.fromJson(response.data);
  }

  @override
  Future<CarrierPickupSummaryListModel> getCarrierPickupData(String day, {DateTime? startDate, DateTime? endDate}) async {
    String path = "/v1/dashboard/carrier-pickup-data?date=$day";
    if (startDate != null && endDate != null) {
      path += "&startDate=${_formatDate(startDate, true)}&endDate=${_formatDate(endDate, false)}";
    }
    final response = await _dio.get(path);
    return CarrierPickupSummaryListModel.fromJson(response.data);
  }

  @override
  Future<NdrDataModel> getNdrData({DateTime? startDate, DateTime? endDate}) async {
    String query = "";
    if (startDate != null && endDate != null) {
      query = "?startDate=${_formatDate(startDate, true)}&endDate=${_formatDate(endDate, false)}";
    }
    final response = await _dio.get("/v1/dashboard/ndr_data$query");
    return NdrDataModel.fromJson(response.data);
  }

  @override
  Future<List<DatewiseNdrCountModel>> getDatewiseNdrCount({DateTime? startDate, DateTime? endDate}) async {
    String query = "";
    if (startDate != null && endDate != null) {
      query = "?startDate=${_formatDate(startDate, true)}&endDate=${_formatDate(endDate, false)}";
    }
    final response = await _dio.get("/v1/dashboard/datewise_ndr_count$query");
    return (response.data as List).map((e) => DatewiseNdrCountModel.fromJson(e)).toList();
  }
}
