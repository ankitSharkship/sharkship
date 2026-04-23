import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceSummary extends ConsumerStatefulWidget {
  const InvoiceSummary({super.key});

  @override
  ConsumerState<InvoiceSummary> createState() => _InvoiceSummaryState();
}

class _InvoiceSummaryState extends ConsumerState<InvoiceSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [Text('HIIIIIII')])),
    );
  }
}
