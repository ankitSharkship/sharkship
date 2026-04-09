import '../entities/courier_partner_entity.dart';
import '../repositories/orders_repository.dart';

class GetCourierPartnersUseCase {
  final OrdersRepository repository;

  GetCourierPartnersUseCase(this.repository);

  Future<List<CourierPartnerEntity>> execute() async {
    return await repository.getCourierPartners();
  }
}
