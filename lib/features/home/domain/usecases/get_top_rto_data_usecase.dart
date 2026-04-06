import '../entities/top_rto_data.dart';
import '../repositories/dashboard_repository.dart';

class GetTopRtoDataUseCase {
  final DashboardRepository repository;

  GetTopRtoDataUseCase(this.repository);

  Future<TopRtoData> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getTopRtoData(startDate: startDate, endDate: endDate);
  }
}
