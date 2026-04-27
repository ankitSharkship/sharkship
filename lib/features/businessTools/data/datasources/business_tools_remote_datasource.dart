import 'package:dio/dio.dart';
import 'package:sharkship/features/businessTools/data/models/pickup_address_model.dart';
import 'package:sharkship/features/businessTools/data/models/pin_details_model.dart';
import 'package:sharkship/features/businessTools/data/models/retail_api_details_model.dart';

class BusinessToolsRemoteDataSource {
  final Dio _dio;

  BusinessToolsRemoteDataSource(this._dio);

  Future<PickupAddressModel> addPickupAddress(Map<String, dynamic> data) async {
    final response = await _dio.post('/v1/address/pickupAddress', data: data);
    return PickupAddressModel.fromJson(response.data);
  }

  Future<void> updatePickupAddress(int id, Map<String, dynamic> data) async {
    await _dio.put('/v1/address/pickupAddress/$id', data: data);
  }

  Future<void> deletePickupAddress(int id) async {
    await _dio.delete('/v1/address/pickupAddress/$id');
  }

  Future<PinDetailsModel> getPinDetails(String pinCode) async {
    final response = await _dio.get('/v1/general/pinDetails', queryParameters: {'pinCode': pinCode});
    return PinDetailsModel.fromJson(response.data);
  }

  Future<RetailApiDetailsModel> getRetailApiDetails() async {
    final response = await _dio.get('/v1/user/retailApiDetails');
    return RetailApiDetailsModel.fromJson(response.data);
  }

  Future<void> requestMisReport({
    required String startDate,
    required String endDate,
    required List<String> statuses,
    required List<String> carriers,
  }) async {
    await _dio.post(
      '/v1/order/misReport',
      queryParameters: {
        'startDate': startDate,
        'endDate': endDate,
        'statuses': statuses,
        'carriers': carriers,
      },
    );
  }
}
