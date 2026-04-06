import '../entities/ndr_data.dart';
import '../repositories/dashboard_repository.dart';

class GetNdrDataUseCase {
  final DashboardRepository repository;

  GetNdrDataUseCase(this.repository);

  Future<NdrData> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getNdrData(startDate: startDate, endDate: endDate);
  }
}
