import 'package:dio/dio.dart';
import '../models/tracking_details_model.dart';

class ShipmentDataSource {
  final Dio _dio;

  ShipmentDataSource(this._dio);

  Future<TrackingDetailsModel> getTrackingDetails(String trackingId) async {
    final response = await _dio.get(
      'v1/order/fetch/awb',
      queryParameters: {'tracking_id': trackingId},
    );

    final data = response.data;
    // Handle different response structures if necessary
    if (data is Map<String, dynamic>) {
      return TrackingDetailsModel.fromJson(data);
    } else {
      throw Exception('Unexpected response format from tracking API');
    }
  }
}
