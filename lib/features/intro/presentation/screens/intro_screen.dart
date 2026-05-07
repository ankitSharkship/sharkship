import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:go_router/go_router.dart';

import 'package:sharkship/core/services/shared_preferences_service.dart';
import 'package:sharkship/routes/app_router.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Future<void> _completeIntro() async {
    await SharedPreferencesService.setHasSeenIntro(true);

    if (!mounted) return;
    context.go(Routes.SPLASH);
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required String buttonText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 80),

          /// Image
          SizedBox(
            height: 280,
            width: MediaQuery.of(context).size.width * 0.5,
            child: SvgPicture.asset(image, fit: BoxFit.contain),
          ),

          const SizedBox(height: 20),

          /// Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          /// Subtitle
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  List<PageViewModel> _pages() {
    return [
      PageViewModel(
        title: "",
        bodyWidget: _buildPage(
          image: 'assets/images/intro/4.svg',
          title: 'Simplify Shipping for Your Business',
          subtitle:
              'Seamlessly manage orders, couriers and customers with one powerful app.',
          onTap: () {},
          buttonText: "Next",
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: _buildPage(
          image: 'assets/images/intro/3.svg',
          title:
              'Create Shipments in Just a Few Taps and Let Us Handle the Rest',
          subtitle:
              'Book pickups, print labels and choose the best courier all from your mobile.',
          onTap: () {},
          buttonText: "Next",
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: _buildPage(
          image: 'assets/images/intro/2.svg',
          title: 'Stay in Control with Real-Time Tracking and Delivery Updates',
          subtitle:
              'Stay updated with every movement from pickup to successful delivery.',
          onTap: () {},
          buttonText: "Next",
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: _buildPage(
          image: 'assets/images/intro/1.svg',
          title: 'Manage Payments, Recharge Wallet and GST Invoices Easily',
          subtitle:
              'Recharge your wallet, get detailed invoices and track expenses easily.',
          onTap: () {},
          buttonText: "Next",
        ),
      ),
      PageViewModel(
        title: "",
        bodyWidget: _buildPage(
          image: 'assets/images/intro/5.svg',
          title: 'Start Shipping Smarter, Save Time and Grow Your Business',
          subtitle:
              'Seamlessly manage orders, couriers and customers with one powerful app.',
          onTap: () {},
          buttonText: "Next",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: _pages(),

        /// Actions
        onDone: _completeIntro,
        onSkip: _completeIntro,

        /// Buttons
        showSkipButton: true,
        skip: const Text("Skip"),

        next: const Icon(Icons.arrow_forward),

        done: const Text(
          "Get Started",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        /// Dots styling (close to your UI)
        dotsDecorator: DotsDecorator(
          size: const Size(6, 6),
          activeSize: const Size(10, 6),
          activeColor: const Color(0xFF1E5AA8),
          color: Colors.grey.shade300,
          spacing: const EdgeInsets.symmetric(horizontal: 4),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        /// Layout tuning
        controlsPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        skipOrBackFlex: 0,
        nextFlex: 0,
        // doneFlex: 0,
      ),
    );
  }
}
