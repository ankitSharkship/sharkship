import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SellerChargesScreen extends ConsumerWidget {
  const SellerChargesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Seller Charges')),
      body: SafeArea(
        child: Column(children: [Center(child: Text('Seller Charges'))]),
      ),
    );
  }
}
