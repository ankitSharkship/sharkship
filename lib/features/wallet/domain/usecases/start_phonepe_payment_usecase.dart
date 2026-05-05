import 'package:sharkship/features/wallet/domain/repositories/phonepe_repository.dart';

class StartPhonePePaymentUseCase {
  final PhonePeRepository repository;

  StartPhonePePaymentUseCase(this.repository);

  Future<Map<String, dynamic>?> call({
    required String request,
    required String flowId,
  }) {
    return repository.startPayment(request: request, flowId: flowId);
  }
}
