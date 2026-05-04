import '../entities/payment_confirm_entity.dart';
import '../repositories/wallet_repository.dart';

class ConfirmPaymentUseCase {
  final WalletRepository repository;

  ConfirmPaymentUseCase(this.repository);

  Future<PaymentConfirmEntity> call({
    required String orderId,
    required String paymentId,
    required String signature,
    String paymentGateway = 'RAZORPAY',
  }) {
    return repository.confirmPayment(
      orderId: orderId,
      paymentId: paymentId,
      signature: signature,
      paymentGateway: paymentGateway,
    );
  }
}
