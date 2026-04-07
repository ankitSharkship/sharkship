import '../entities/business_entities.dart';
import '../repositories/dashboard_repository.dart';

class GetBusinessOverviewUseCase {
  final DashboardRepository repository;

  GetBusinessOverviewUseCase(this.repository);

  Future<List<BusinessOverviewCount>> call(
      {DateTime? startDate, DateTime? endDate}) async {
    return await repository.getBusinessOverview(
        startDate: startDate, endDate: endDate);
  }
}

class GetMapOrdersUseCase {
  final DashboardRepository repository;

  GetMapOrdersUseCase(this.repository);

  Future<List<StateStatusCount>> call({DateTime? startDate, DateTime? endDate}) async {
    return await repository.getMapOrders(startDate: startDate, endDate: endDate);
  }
}

class GetZoneDistributionUseCase {
  final DashboardRepository repository;

  GetZoneDistributionUseCase(this.repository);

  Future<List<ZonePercentageCount>> call(
      {DateTime? startDate, DateTime? endDate}) async {
    return await repository.getZoneDistribution(
        startDate: startDate, endDate: endDate);
  }
}
