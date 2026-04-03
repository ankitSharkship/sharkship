import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import 'package:sharkship/features/home/domain/repositories/dashboard_repository.dart';

class GetCarrierPickupDataUsecase {
  final DashboardRepository repo;
  GetCarrierPickupDataUsecase(this.repo);

  Future<CarrierPickupSummaryList> call(String day) async {
    return repo.getCarrierPickupData(day);
  }
}
