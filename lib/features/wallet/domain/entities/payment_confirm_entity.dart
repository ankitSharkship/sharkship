class PaymentConfirmEntity {
  final bool success;
  final String message;
  final String status;

  const PaymentConfirmEntity({
    required this.success,
    required this.message,
    required this.status,
  });
}
