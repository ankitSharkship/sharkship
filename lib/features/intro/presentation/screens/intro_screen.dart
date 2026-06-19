import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:sharkship/core/services/shared_preferences_service.dart';
import 'package:sharkship/routes/app_router.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroPageData {
  final String image;
  final String title;
  final String subtitle;
  const _IntroPageData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const _pages = [
    _IntroPageData(
      image: 'assets/images/intro/4.svg',
      title: 'Simplify Shipping for Your Business',
      subtitle:
          'Seamlessly manage orders, couriers and customers with one powerful app.',
    ),
    _IntroPageData(
      image: 'assets/images/intro/3.svg',
      title: 'Create Shipments in Just a Few Taps and Let Us Handle the Rest',
      subtitle:
          'Book pickups, print labels and choose the best courier all from your mobile.',
    ),
    _IntroPageData(
      image: 'assets/images/intro/2.svg',
      title: 'Stay in Control with Real-Time Tracking and Delivery Updates',
      subtitle:
          'Stay updated with every movement from pickup to successful delivery.',
    ),
    _IntroPageData(
      image: 'assets/images/intro/1.svg',
      title: 'Manage Payments, Recharge Wallet and GST Invoices Easily',
      subtitle:
          'Recharge your wallet, get detailed invoices and track expenses easily.',
    ),
    _IntroPageData(
      image: 'assets/images/intro/5.svg',
      title: 'Start Shipping Smarter, Save Time and Grow Your Business',
      subtitle:
          'Seamlessly manage orders, couriers and customers with one powerful app.',
    ),
  ];

  Future<void> _completeIntro() async {
    await SharedPreferencesService.setHasSeenIntro(true);
    if (!mounted) return;
    context.go(Routes.SPLASH);
  }

  void _onNext() {
    if (_currentPage == _pages.length - 1) {
      _completeIntro();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPageContent(_IntroPageData data) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints here come straight from Expanded -> always bounded,
        // never infinite/loose — so FittedBox has something real to scale into.
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth - 48,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 320,
                      width: (constraints.maxWidth - 48) * 0.75,
                      child: SvgPicture.asset(data.image, fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      data.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      data.subtitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 6,
          width: isActive ? 10 : 6,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF1E5AA8) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final isLast = _currentPage == _pages.length - 1;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) =>
                    _buildPageContent(_pages[index]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16 + bottomInset,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: isLast
                        ? const SizedBox.shrink()
                        : TextButton(
                            onPressed: _completeIntro,
                            child: const Text("Skip"),
                          ),
                  ),
                  _buildDots(),
                  SizedBox(
                    width: 100,
                    child: isLast
                        ? TextButton(
                            onPressed: _onNext,
                            child: const Text(
                              "Get Started",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: _onNext,
                            icon: const Icon(Icons.arrow_forward),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
