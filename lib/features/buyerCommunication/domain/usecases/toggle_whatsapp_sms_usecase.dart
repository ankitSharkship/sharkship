
import '../repositories/buyer_communication_repository.dart';

class ToggleWhatsappSmsUsecase {
  final BuyerCommunicationRepository repository;

  ToggleWhatsappSmsUsecase(this.repository);

  Future<void> execute() async {
    return await repository.toggleWhatsappConfig();
  }
}
