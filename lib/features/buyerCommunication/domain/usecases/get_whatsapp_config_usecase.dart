import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import '../entities/whatsapp_config_entity.dart';
import '../repositories/buyer_communication_repository.dart';

class GetWhatsappConfigUseCase {
  final BuyerCommunicationRepository repository;

  GetWhatsappConfigUseCase(this.repository);

  Future<Either<Failure, WhatsappConfigEntity>> call() async {
    return await repository.getWhatsappConfig();
  }
}
