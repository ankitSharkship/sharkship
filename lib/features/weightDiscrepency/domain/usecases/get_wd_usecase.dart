import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

import '../entities/wd_response_entity.dart';
import '../repositories/wd_repository.dart';

class GetWdUsecase {
  final WdRepository repository;

  GetWdUsecase(this.repository);

  Future<WdResponseEntity> execute(OrderListParams params) async {
    return await repository.getWeightDiscrepancies(
      params
    );
  }
}
