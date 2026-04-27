import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/businessTools/presentation/state/reports_notifier.dart';
import 'package:sharkship/features/businessTools/presentation/widgets/get_orders_mis_report.dart';
import 'package:sharkship/shared/constants/colors.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh the notifier to fetch fresh partners on reopening
    Future.microtask(() => ref.invalidate(reportsProvider));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      appBar: AppBar(
        title: Text('Manage Reports'),
        backgroundColor: ColorManager.scaffoldBg,
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsGeometry.symmetric(horizontal: 7),
                child: GetOrdersMISReport(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
