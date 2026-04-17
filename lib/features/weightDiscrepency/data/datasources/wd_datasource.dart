import 'package:dio/dio.dart';
import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import '../models/wd_model.dart';

class WdDataSource {
  final Dio _dio;

  WdDataSource(this._dio);

  Future<Map<String, dynamic>> getWeightDiscrepancies(OrderListParams params) async {
    final response = await _dio.get(
      '/v1/weight-dispute/list',
      queryParameters: {
        'total': params.total,
        'skip': params.skip,
        'startDate': params.startDate,
        'endDate': params.endDate,
        'carrier': (params.carrier == null || params.carrier == 'All')
            ? ''
            : params.carrier!,
        if (params.status != null && params.status != 'All')
          'status': params.status,
      },
    );

    final List<dynamic> data = response.data;
    final totalCountStr =
        response.headers.value('totalcount') ??
        response.headers.value('totalCount') ??
        '0';

    return {
      'items': data.map((json) => WdModel.fromJson(json)).toList(),
      'totalCount': int.tryParse(totalCountStr) ?? data.length,
    };
  }

  Future<void> uploadDispute({
    required String trackingId,
    required List<String> filePaths,
  }) async {
    final formData = FormData();
    for (final path in filePaths) {
      formData.files.add(MapEntry(
        'file',
        await MultipartFile.fromFile(path),
      ));
    }

    await _dio.post(
      '/v1/weight-dispute/upload',
      data: formData,
      options: Options(
        headers: {
          'tracking_id': trackingId,
        },
      ),
    );
  }
}
