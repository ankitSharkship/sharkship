import '../entities/ndr_status_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetNdrStatusCountUsecase {
  final DashboardRepository repository;
  GetNdrStatusCountUsecase(this.repository);

  Future<NdrStatusSummary> call() async {
    return await repository.getNdrStatusCount();
  }
}
