import '../entities/datewise_ndr_count.dart';
import '../repositories/dashboard_repository.dart';

class GetDatewiseNdrCountUseCase {
  final DashboardRepository repository;

  GetDatewiseNdrCountUseCase(this.repository);

  Future<List<DatewiseNdrCount>> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getDatewiseNdrCount(startDate: startDate, endDate: endDate);
  }
}
