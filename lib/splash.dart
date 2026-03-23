import 'package:flutter/material.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: const ThreeDotsLoader());
  }
}
