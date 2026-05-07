import 'package:flutter/material.dart';
import 'package:sharkship/features/wallet/domain/entities/coupon_entity.dart';
import 'package:sharkship/shared/constants/colors.dart';

class CouponTicketCard extends StatelessWidget {
  final CouponEntity coupon;
  final bool isSelected;
  final VoidCallback onApply;
  final bool isValid;

  const CouponTicketCard({
    super.key,
    required this.isValid,
    required this.coupon,
    required this.isSelected,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [ColorManager.secondaryBlue, ColorManager.primaryBlue],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            /// Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Code + Apply
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      coupon.couponCode.toUpperCase(),
                      // style: const TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 20,
                      //   fontWeight: FontWeight.w700,
                      //   letterSpacing: 1,
                      // ),
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),

                    /// Apply Button
                    GestureDetector(
                      onTap: onApply,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isValid ? Colors.white : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isSelected ? "Applied" : "Apply",
                          style: const TextStyle(
                            color: Color(0xFF2A6CF0),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Description
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 5,
                      ),
                      child: Text(
                        coupon.couponDescription,
                        softWrap: true,
                        maxLines: 2,
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.white),
                      ),
                    ),
                    // const SizedBox(height: 6),

                    // /// Min/Max
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    //   child: Text(
                    //     "Min amount: ₹${coupon.minAmount.toInt()} | Max discount: ₹${coupon.maxCashbackAmount.toInt()}",
                    //     style: Theme.of(
                    //       context,
                    //     ).textTheme.bodySmall?.copyWith(color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 18.0;

    final path = Path();

    path.moveTo(0, 0);

    /// Top line
    path.lineTo(size.width, 0);

    /// Right side before cut
    path.lineTo(size.width, size.height / 2 - radius);

    /// Right cut (inward arc)
    path.arcToPoint(
      Offset(size.width, size.height / 2 + radius),
      radius: const Radius.circular(radius),
      clockwise: false,
    );

    /// Bottom right
    path.lineTo(size.width, size.height);

    /// Bottom line
    path.lineTo(0, size.height);

    /// Left side before cut
    path.lineTo(0, size.height / 2 + radius);

    /// Left cut (inward arc)
    path.arcToPoint(
      Offset(0, size.height / 2 - radius),
      radius: const Radius.circular(radius),
      clockwise: false,
    );

    /// Close
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
