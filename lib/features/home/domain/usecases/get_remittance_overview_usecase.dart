import '../entities/remittance_overview.dart';
import '../repositories/dashboard_repository.dart';

class GetRemittanceOverviewUseCase {
  final DashboardRepository repository;

  GetRemittanceOverviewUseCase(this.repository);

  Future<RemittanceOverview> call() async {
    return await repository.getRemittanceOverview();
  }
}
