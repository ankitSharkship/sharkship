import 'dart:io';

import 'package:sharkship/features/orders/domain/repositories/orders_repository.dart';

class BulkUploadUsecase {
  final OrdersRepository repo;
  const BulkUploadUsecase(this.repo);

  Future<bool> execute(File file) async{
    return await repo.handleBulkUpload(file);
  }
}
