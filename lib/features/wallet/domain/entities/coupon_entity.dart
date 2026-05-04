class CouponEntity {
  final int id;
  final String couponCode;
  final double minAmount;
  final double maxCashbackAmount;
  final String status;
  final bool isUsed;
  final bool isRepeated;
  final String couponDescription;
  final int discountPercentage;
  final DateTime createdAt;

  const CouponEntity({
    required this.id,
    required this.couponCode,
    required this.minAmount,
    required this.maxCashbackAmount,
    required this.status,
    required this.isUsed,
    required this.isRepeated,
    required this.couponDescription,
    required this.discountPercentage,
    required this.createdAt,
  });
}
