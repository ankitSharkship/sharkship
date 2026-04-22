import '../entities/message_metrics_entity.dart';
import '../repositories/finance_repository.dart';

class GetMessageMetricsUseCase {
  final FinanceRepository _repository;

  GetMessageMetricsUseCase(this._repository);

  Future<MessageMetricsEntity> execute({
    required String startDate,
    required String endDate,
  }) {
    return _repository.getMessageMetrics(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
