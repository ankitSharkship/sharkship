import 'weight_discrepancy_entity.dart';

class WdResponseEntity {
  final int totalCount;
  final List<WeightDiscrepancyEntity> items;

  WdResponseEntity({
    required this.totalCount,
    required this.items,
  });
}
