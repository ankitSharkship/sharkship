import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/user/presentation/state/user_notifier.dart';
import 'package:sharkship/shared/widgets/loader.dart';
import '../widgets/home_header.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/section_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);
    return Scaffold(
      body: userState.when(
        loading: () => const Center(child: ThreeDotsLoader()),
        error: (err, _) => Center(child: Text(err.toString())),
        data: (user) {
          final userName = user?.firstName;
          final profileUrl = user?.profileImageUrl;
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  SizedBox(height: 10),
                  HomeHeader(name: userName, profileUrl: profileUrl),
                  SizedBox(height: 20),

                  HeroCarousel(),
                  SizedBox(height: 20),

                  Text(
                    "Quick Actions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),
                  QuickActionsGrid(),

                  SizedBox(height: 20),

                  Text(
                    "Getting Started",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 12),

                  SectionCard(
                    title: "Complete KYC",
                    description:
                        "Verify your identity and unlock full access to Deliverex features.",
                    buttonText: "Complete Now",
                    icon: Icons.verified_user_outlined,
                  ),

                  SizedBox(height: 12),

                  SectionCard(
                    title: "Ship Your First Order",
                    description:
                        "Create your first shipment and test the platform.",
                    buttonText: "Start Shipping",
                    icon: Icons.local_shipping_outlined,
                  ),
                  SizedBox(height: 12),
                  SectionCard(
                    title: "Activate Offer",
                    description: "Get discounts on your shipments.",
                    buttonText: "Activate",
                    icon: Icons.local_offer_outlined,
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
