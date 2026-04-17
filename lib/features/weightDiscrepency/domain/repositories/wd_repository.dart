import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

import '../entities/wd_response_entity.dart';

abstract class WdRepository {
  Future<WdResponseEntity> getWeightDiscrepancies(OrderListParams params);

  Future<void> uploadDispute({
    required String trackingId,
    required List<String> filePaths,
  });
}
