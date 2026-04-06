import '../entities/top_delivered_data.dart';
import '../repositories/dashboard_repository.dart';

class GetTopDeliveredDataUseCase {
  final DashboardRepository repository;

  GetTopDeliveredDataUseCase(this.repository);

  Future<TopDeliveredData> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getTopDeliveredData(
        startDate: startDate, endDate: endDate);
  }
}
