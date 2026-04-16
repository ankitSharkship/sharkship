import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';
import '../entity/ndr_response_entity.dart';
import '../repositories/ndr_repository.dart';

class GetNdrOrdersUseCase {
  final NdrRepository _repository;

  GetNdrOrdersUseCase(this._repository);

  Future<NdrResponseEntity> execute(OrderListParams params) {
    return _repository.getNdrOrders(params);
  }
}
