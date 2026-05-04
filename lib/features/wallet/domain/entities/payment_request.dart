class PaymentRequest {
  final double amount;
  final String orderId;
  final String mobileNumber;

  PaymentRequest({
    required this.amount,
    required this.orderId,
    required this.mobileNumber,
  });
}
