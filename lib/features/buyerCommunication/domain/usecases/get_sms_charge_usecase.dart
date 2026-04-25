import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import '../entities/sms_charge_entity.dart';
import '../repositories/buyer_communication_repository.dart';

class GetSmsChargeUseCase {
  final BuyerCommunicationRepository repository;

  GetSmsChargeUseCase(this.repository);

  Future<Either<Failure, SmsChargeEntity>> call() async {
    return await repository.getSmsCharge();
  }
}
