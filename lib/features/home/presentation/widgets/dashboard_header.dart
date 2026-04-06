import 'package:flutter/material.dart';
import 'date_range_picker_modal.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DateRangePickerModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Dashboard",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          IconButton(
            onPressed: () => _showDatePicker(context),
            icon: const Icon(Icons.calendar_month_outlined, size: 28),
          ),
        ],
      ),
    );
  }
}