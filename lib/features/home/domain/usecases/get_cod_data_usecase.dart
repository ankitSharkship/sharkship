import '../entities/cod_data.dart';
import '../repositories/dashboard_repository.dart';

class GetCodDataUseCase {
  final DashboardRepository repository;

  GetCodDataUseCase(this.repository);

  Future<List<CodData>> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getCodData(startDate: startDate, endDate: endDate);
  }
}
