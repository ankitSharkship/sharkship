import 'dart:async';
import 'package:flutter/material.dart';
import 'hero_card.dart';

class HeroCarousel extends StatefulWidget {
  const HeroCarousel({super.key});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController controller = PageController();
  int index = 0;

  final items = const [
    HeroCardData(
      title: "Start Shipping in Minutes",
      description:
          "Create your first shipment effortlessly and go live without delay & Reach customers across India with fast, reliable delivery.",
      buttonText: "Create Shipment",
      asset: "assets/images/home/1.svg",
    ),
    HeroCardData(
      title: "Get 10% OFF on Your First 50 Shipments",
      description:
          "Enjoy an exclusive welcome offer designed for new sellers & Save on shipping costs as you scale your business.",
      buttonText: "Activate Offer",
      asset: "assets/images/home/2.svg",
    ),
    HeroCardData(
      title: "Real-Time Order Tracking Now Live",
      description:
          "Keep your customers informed with live tracking and updates & Build trust and reduce support queries instantly.",
      buttonText: "Enable Live Tracking",
      asset: "assets/images/home/3.svg",
    ),
    HeroCardData(
      title: "Deliver with 25+ Courier Partners",
      description:
          "Choose from top-rated delivery partners for every pin code & Get competitive rates with seamless auto allocation.",
      buttonText: "View Courier List",
      asset: "assets/images/home/4.svg",
    ),
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      index = (index + 1) % items.length;
      controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView.builder(
            controller: controller,
            itemCount: items.length,
            itemBuilder: (_, i) => HeroCard(data: items[i]),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: i == index ? 8 : 6,
              height: i == index ? 8 : 6,
              decoration: BoxDecoration(
                color: i == index ? Colors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
