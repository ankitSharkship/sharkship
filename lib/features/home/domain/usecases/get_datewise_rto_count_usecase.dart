import '../entities/datewise_rto_count.dart';
import '../repositories/dashboard_repository.dart';

class GetDatewiseRtoCountUseCase {
  final DashboardRepository repository;

  GetDatewiseRtoCountUseCase(this.repository);

  Future<List<DatewiseRtoCount>> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getDatewiseRtoCount(startDate: startDate, endDate: endDate);
  }
}
