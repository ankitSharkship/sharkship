import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sharkship/features/shipments/presentation/state/tracking_notifier.dart';
import 'package:sharkship/features/shipments/presentation/widgets/feature_card.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShipmentTracking extends ConsumerStatefulWidget {
  const ShipmentTracking({super.key});

  @override
  ConsumerState<ShipmentTracking> createState() => _ShipmentTrackingState();
}

class _ShipmentTrackingState extends ConsumerState<ShipmentTracking> {
  final TextEditingController _awbController = TextEditingController();

  // Add / remove cards here — the grid adapts automatically.
  final List<FeatureCardData> _features = const [
    FeatureCardData(
      icon: Icons.calculate_rounded,
      title: 'Calculate Shipment Amount',
      description:
          'Find out the exact cost to ship your package based on distance, package dimensions, weight and product price.',
      isPrimary: true,
    ),
    FeatureCardData(
      icon: Icons.swap_horiz_rounded,
      title: 'Return Request For Your Shipment',
      description:
          'Easily request a return for undelivered or unwanted items and track the process step by step.',
      isPrimary: false,
    ),
    FeatureCardData(
      icon: Icons.local_shipping_rounded,
      title: 'Check Details of your Orders',
      description:
          'View all your orders with real - time status, item details and delivery updates - all in one place.',
      isPrimary: false,
    ),
    FeatureCardData(
      icon: Icons.local_shipping_rounded,
      title: 'Track and Monitor Your Shipment',
      description:
          'Track all shipment stages - Ready to Ship, Shipped, Out for Delivery, Delivered and more - all in one view.',
      isPrimary: false,
    ),
    FeatureCardData(
      icon: Icons.dashboard,
      title: 'Get A Personalized Dashboard',
      description:
          'Track all your shipments and returns in one place. Monitor delivery status and shipping performance easily',
      isPrimary: false,
    ),
    FeatureCardData(
      icon: Icons.attach_money_outlined,
      title: 'Accurate Shipping Estimates',
      description:
          'Explore detailed rate breakdowns, zone-wise pricing, and additional fees before shipping.',
      isPrimary: false,
    ),
  ];

  @override
  void dispose() {
    _awbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      appBar: AppBar(
        backgroundColor: ColorManager.lightBlueBg,
        title: Text('Shipment Tracking'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Top section: light blue background ──────────────────
              Container(
                padding: EdgeInsets.only(bottom: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: ColorManager.lightBlueBg,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title + subtitle
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Let's Track your package",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Please Enter AWB Number to track your order.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Search bar ─────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 14),
                            // Truck icon
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F0FB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.local_shipping_outlined,
                                color: Color(0xFF2B6FD4),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Text field
                            Expanded(
                              child: TextField(
                                controller: _awbController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter AWB Number',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFB0B8C5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 2,
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF111827),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Track button
                            GestureDetector(
                              onTap: () {
                                // Handle track action

                                context.push(
                                  Routes.TRACKING_RESULT,
                                  extra: _awbController.text,
                                );
                              },
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2B6FD4),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(14),
                                    bottomRight: Radius.circular(14),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Track',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ── SVG illustration ───────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 280,
                      child: SvgPicture.asset(
                        'assets/images/orders/OBJECTS.svg',
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── "What are you looking for?" heading ─────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: const [
                    Text(
                      'What are you looking for?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Here are best features',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ── Feature cards grid ───────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  // Disable GridView's own scrolling — parent SingleChildScrollView handles it
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    // Adjust childAspectRatio to control card height.
                    // Lower value = taller cards.
                    childAspectRatio: 0.72,
                  ),
                  itemCount: _features.length,
                  itemBuilder: (context, index) {
                    return FeatureCard(cardData: _features[index]);
                  },
                ),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
