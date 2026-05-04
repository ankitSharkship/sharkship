import 'package:sharkship/features/wallet/domain/entities/payment_request.dart';
import 'package:sharkship/features/wallet/domain/repositories/payment_repository.dart';

class StartPaymentUseCase {
  final PaymentRepository repo;

  StartPaymentUseCase(this.repo);

  Future<void> call(PaymentRequest request) {
    return repo.startPayment(request);
  }
}