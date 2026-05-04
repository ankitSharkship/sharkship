class PaymentInitiateEntity {
  final String orderId;
  final int amount;
  final int amountDue;
  final int amountPaid;
  final int attempts;
  final int createdAt;
  final String currency;
  final String entity;
  final String id;
  final List<dynamic> notes;
  final String? offerId;
  final String receipt;
  final String status;

  const PaymentInitiateEntity({
    required this.orderId,
    required this.amount,
    required this.amountDue,
    required this.amountPaid,
    required this.attempts,
    required this.createdAt,
    required this.currency,
    required this.entity,
    required this.id,
    required this.notes,
    this.offerId,
    required this.receipt,
    required this.status,
  });
}
