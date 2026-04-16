import '../../domain/entity/ndr_response_entity.dart';
import 'ndr_order_model.dart';

class NdrResponseModel extends NdrResponseEntity {
  NdrResponseModel({
    required super.totalCount,
    required List<NdrOrderModel> super.orders,
  });

  factory NdrResponseModel.fromJson(Map<String, dynamic> json) {
    return NdrResponseModel(
      totalCount: json['totalCount'] ?? 0,
      orders: (json['orders'] as List? ?? [])
          .map((i) => NdrOrderModel.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Use when totalCount comes from response headers.
  factory NdrResponseModel.fromListWithTotal(List<dynamic> list, int totalCount) {
    final orders = list
        .map((i) => NdrOrderModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return NdrResponseModel(totalCount: totalCount, orders: orders);
  }

  /// Fallback: derive totalCount from list length alone.
  factory NdrResponseModel.fromList(List<dynamic> list) {
    final orders = list
        .map((i) => NdrOrderModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return NdrResponseModel(totalCount: orders.length, orders: orders);
  }
}
