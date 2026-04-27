import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class RequestMisReportUseCase {
  final BusinessToolsRepository repository;

  RequestMisReportUseCase(this.repository);

  Future<Either<Failure, void>> execute({
    required String startDate,
    required String endDate,
    required List<String> statuses,
    required List<String> carriers,
  }) {
    return repository.requestMisReport(
      startDate: startDate,
      endDate: endDate,
      statuses: statuses,
      carriers: carriers,
    );
  }
}
