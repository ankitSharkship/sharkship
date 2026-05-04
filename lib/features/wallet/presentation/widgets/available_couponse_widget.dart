import 'package:flutter/material.dart';
import 'package:sharkship/features/wallet/domain/entities/coupon_entity.dart';
import 'package:sharkship/features/wallet/presentation/widgets/coupon_card.dart';

class AvailableCouponsWidget extends StatelessWidget {
  final List<CouponEntity> coupons;
  final CouponEntity? selectedCoupon;
  final Function(CouponEntity) onApply;

  const AvailableCouponsWidget({
    super.key,
    required this.coupons,
    this.selectedCoupon,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text("No coupons available"),
      );
    }

    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: coupons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final coupon = coupons[index];

          return CouponTicketCard(
            coupon: coupon,
            isSelected: selectedCoupon?.id == coupon.id,
            onApply: () => onApply(coupon),
          );
        },
      ),
    );
  
  }
}
