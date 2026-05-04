import '../../domain/entities/coupon_entity.dart';

class CouponModel extends CouponEntity {
  const CouponModel({
    required super.id,
    required super.couponCode,
    required super.minAmount,
    required super.maxCashbackAmount,
    required super.status,
    required super.isUsed,
    required super.isRepeated,
    required super.couponDescription,
    required super.discountPercentage,
    required super.createdAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as int,
      couponCode: json['coupon_code'] as String,
      minAmount: (json['min_amount'] as num).toDouble(),
      maxCashbackAmount: (json['max_cashback_amount'] as num).toDouble(),
      status: json['status'] as String,
      isUsed: json['isUsed'] as bool,
      isRepeated: json['is_repeated'] as bool,
      couponDescription: json['coupon_description'] as String,
      discountPercentage: json['discount_percentage'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coupon_code': couponCode,
      'min_amount': minAmount,
      'max_cashback_amount': maxCashbackAmount,
      'status': status,
      'isUsed': isUsed,
      'is_repeated': isRepeated,
      'coupon_description': couponDescription,
      'discount_percentage': discountPercentage,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
