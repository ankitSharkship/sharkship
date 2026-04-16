import '../entity/ndr_reattempt_params.dart';
import '../repositories/ndr_repository.dart';

class ReattemptNdrOrdersUseCase {
  final NdrRepository _repository;

  ReattemptNdrOrdersUseCase(this._repository);

  Future<void> execute(NdrReattemptParams params) {
    return _repository.reattemptNdrOrders(params);
  }
}
