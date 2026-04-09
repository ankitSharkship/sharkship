import '../entities/courier_priority_entity.dart';
import '../repositories/orders_repository.dart';

class GetCourierPriorityUseCase {
  final OrdersRepository repository;

  GetCourierPriorityUseCase(this.repository);

  Future<CourierPriorityEntity> execute() async {
    return await repository.getCourierPriority();
  }
}
