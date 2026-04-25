import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import '../repositories/buyer_communication_repository.dart';

class UpdateWhatsappSmsConfigUseCase {
  final BuyerCommunicationRepository repository;

  UpdateWhatsappSmsConfigUseCase(this.repository);

  Future<Either<Failure, void>> call(Map<String, dynamic> data) async {
    return await repository.updateWhatsappSmsConfig(data);
  }
}
