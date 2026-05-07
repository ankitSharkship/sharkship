import 'package:dio/dio.dart';

import 'package:sharkship/features/ndr/domain/entity/ndr_order_entity.dart';
import 'package:sharkship/features/ndr/domain/entity/ndr_reattempt_params.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import '../models/ndr_response_model.dart';

class NdrDataSource {
  final Dio _dio;

  NdrDataSource(this._dio);

  Future<NdrResponseModel> getNdrOrders(OrderListParams params) async {
    final response = await _dio.get(
      'v1/order/order_ndr_list',
      queryParameters: params.toJson(),
    );

    // totalCount is sent in the response headers as 'totalcount' (lowercase)
    final totalCount =
        int.tryParse(response.headers.value('totalcount') ?? '') ?? 0;

    final body = response.data;

    if (body is List) {
      return NdrResponseModel.fromListWithTotal(body, totalCount);
    }

    final data = body['data'] ?? body;
    if (data is List) {
      return NdrResponseModel.fromListWithTotal(data, totalCount);
    }

    return NdrResponseModel.fromJson(data as Map<String, dynamic>);
  }

  Future<void> reattemptNdrOrders(NdrReattemptParams params) async {
    await _dio.put(
      'v1/order/ndr/re-attempt',
      data: params.toJson(),
      options: Options(headers: {"move_to": "RE_ATTEMPTED"}),
    );
  }
}
