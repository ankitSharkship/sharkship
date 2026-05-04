import '../entities/payment_initiate_entity.dart';
import '../repositories/wallet_repository.dart';

class InitiatePaymentUseCase {
  final WalletRepository repository;

  InitiatePaymentUseCase(this.repository);

  Future<PaymentInitiateEntity> call({
    required double amount,
    String? couponCode,
    String paymentGateway = 'RAZORPAY',
  }) {
    return repository.initiatePayment(
      amount: amount,
      couponCode: couponCode,
      paymentGateway: paymentGateway,
    );
  }
}
