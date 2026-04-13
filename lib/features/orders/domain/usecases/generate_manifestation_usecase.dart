import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class GenerateManifestationUseCase {
  final OrdersRepository _repository;

  GenerateManifestationUseCase(this._repository);

  Future<void> execute(List<int> orderIds) async {
    await _repository.generateManifestation(orderIds);
  }
}
