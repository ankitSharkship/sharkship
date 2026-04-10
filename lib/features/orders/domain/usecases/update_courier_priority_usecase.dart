import '../repositories/orders_repository.dart';

class UpdateCourierPriorityUseCase {
  final OrdersRepository repository;

  UpdateCourierPriorityUseCase(this.repository);

  Future<bool> execute(Map<String, dynamic> data) async {
    return await repository.updateCourierPriority(data);
  }
}
