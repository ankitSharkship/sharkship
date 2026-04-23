import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/finance/domain/entities/remittance_entity.dart';
import 'package:sharkship/features/finance/domain/repositories/finance_repository.dart';
import 'package:sharkship/features/finance/presentation/state/remittance_notifier.dart';

class GetRemittanceCyclesUseCase {
  final FinanceRepository repository;

  GetRemittanceCyclesUseCase(this.repository);

  Future<Either<Failure, RemittanceCycleResponse>> call(
      RemittanceCycleParams params) async {
    return await repository.getRemittanceCycles(
      total: params.total,
      skip: params.skip,
      startDate: params.startDate,
      endDate: params.endDate,
      status: params.status,
      businessName: params.businessName,
      remittanceId: params.remittanceId,
      userId: params.userId,
      phone: params.phone,
    );
  }
}
