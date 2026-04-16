import 'ndr_order_entity.dart';

class NdrResponseEntity {
  final int totalCount;
  final List<NdrOrderEntity> orders;

  NdrResponseEntity({
    required this.totalCount,
    required this.orders,
  });
}
