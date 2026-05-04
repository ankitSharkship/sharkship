import 'package:sharkship/features/wallet/data/datasources/razorpay_datasource.dart';
import 'package:sharkship/features/wallet/domain/entities/payment_request.dart';
import 'package:sharkship/features/wallet/domain/repositories/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RazorpayDataSource dataSource;

  PaymentRepositoryImpl(this.dataSource);

  @override
  Future<void> startPayment(PaymentRequest request) async {
    dataSource.openCheckout(
      orderId: request.orderId,
      amount: request.amount,
      mobileNumber: request.mobileNumber
    );
  }
}