import 'package:sharkship/features/wallet/domain/entities/payment_request.dart';

abstract class PaymentRepository {
  Future<void> startPayment(PaymentRequest request);
}