import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import '../repositories/buyer_communication_repository.dart';

class SendWhatsappDemoUseCase {
  final BuyerCommunicationRepository repository;

  SendWhatsappDemoUseCase(this.repository);

  Future<Either<Failure, void>> call(String phoneNo) async {
    return await repository.sendWhatsappDemo(phoneNo);
  }
}
