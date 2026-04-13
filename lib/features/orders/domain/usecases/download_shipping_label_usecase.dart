import '../repositories/orders_repository.dart';

class DownloadShippingLabelUseCase {
  final OrdersRepository repository;

  DownloadShippingLabelUseCase(this.repository);

  Future<void> execute(List<int> orderIds) async {
    return await repository.downloadShippingLabel(orderIds);
  }
}
