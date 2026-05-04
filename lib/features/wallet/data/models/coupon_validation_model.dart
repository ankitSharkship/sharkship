import '../../domain/entities/coupon_validation_entity.dart';

class CouponValidationModel extends CouponValidationEntity {
  const CouponValidationModel({
    required super.cashbackAmt,
  });

  factory CouponValidationModel.fromJson(Map<String, dynamic> json) {
    return CouponValidationModel(
      cashbackAmt: (json['cashbackAmt'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cashbackAmt': cashbackAmt,
    };
  }
}
