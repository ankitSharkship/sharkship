import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class DownloadTemplateUsecase {
  final OrdersRepository repo;
  const DownloadTemplateUsecase(this.repo);

  Future<void> execute() async {
    return await repo.downloadTemplate();
  }
}
