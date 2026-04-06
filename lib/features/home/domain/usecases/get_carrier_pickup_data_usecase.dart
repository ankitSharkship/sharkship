import 'package:sharkship/features/home/domain/entities/pickups_entities/carrier_pickup_summary_list.dart';
import 'package:sharkship/features/home/domain/repositories/dashboard_repository.dart';

class GetCarrierPickupDataUsecase {
  final DashboardRepository repository;

  GetCarrierPickupDataUsecase(this.repository);

  Future<CarrierPickupSummaryList> call(String day, {DateTime? startDate, DateTime? endDate}) async {
    return await repository.getCarrierPickupData(day, startDate: startDate, endDate: endDate);
  }
}
