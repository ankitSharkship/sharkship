import 'package:sharkship/features/home/domain/entities/ndr_status_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetNdrStatusCountUsecase {
  final DashboardRepository repository;

  GetNdrStatusCountUsecase(this.repository);

  Future<NdrStatusSummary> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getNdrStatusCount(startDate: startDate, endDate: endDate);
  }
}
