import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class DownloadOrderInvoiceUseCase {
  final OrdersRepository _repository;

  DownloadOrderInvoiceUseCase(this._repository);

  Future<void> execute(Map<String, dynamic> config, List<int> orderIds) async {
    await _repository.updateInvoiceConfiguration(config);
    await _repository.downloadOrderInvoice(orderIds);
  }
}
