import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayDataSource {
  final Razorpay _razorpay = Razorpay();

  void init({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onFailure,
  }) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onFailure);
  }

  void openCheckout({
    required String orderId,
    required double amount,
    required String mobileNumber,
  }) {
    var options = {
      'key': dotenv.env['RAZORPAY_KEY'],
      'amount': (amount * 100).toInt(),
      'order_id': orderId,
      'name': 'Sharkship',
      'description': 'Wallet Topup',
      'prefill': {'contact': mobileNumber},
    };

    _razorpay.open(options);
  }

  void dispose() {
    _razorpay.clear();
  }
}
