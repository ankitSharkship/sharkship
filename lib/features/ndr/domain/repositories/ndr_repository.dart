import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import '../entity/ndr_response_entity.dart';
import '../entity/ndr_reattempt_params.dart';

abstract class NdrRepository {
  Future<NdrResponseEntity> getNdrOrders(OrderListParams params);
  Future<void> reattemptNdrOrders(NdrReattemptParams params);
}
