import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_providers.dart';
import 'package:sharkship/shared/constants/colors.dart';

class DateRangePickerModal extends ConsumerStatefulWidget {
  const DateRangePickerModal({super.key});

  @override
  ConsumerState<DateRangePickerModal> createState() => _DateRangePickerModalState();
}

class _DateRangePickerModalState extends ConsumerState<DateRangePickerModal> {
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    final currentRange = ref.read(dashboardDateProvider);
    _startDate = currentRange.start;
    _endDate = currentRange.end;
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorManager.primaryBlue,
              onPrimary: Colors.white,
              onSurface: ColorManager.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
          if (_startDate.isAfter(_endDate)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFFE8F4F8), // Light bluish background from image
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.black, size: 24),
              const SizedBox(width: 12),
              const Text(
                'Select Date Range',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Start Date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          _buildDateField(
            DateFormat('dd MMM yyyy').format(_startDate),
            () => _selectDate(context, true),
          ),
          const SizedBox(height: 20),
          const Text(
            'End Date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          _buildDateField(
            DateFormat('dd MMM yyyy').format(_endDate),
            () => _selectDate(context, false),
          ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2193b0),
                  const Color(0xFF6dd5ed),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2193b0).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                ref.read(dashboardDateProvider.notifier).updateRange(
                  DateTimeRange(start: _startDate, end: _endDate),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDateField(String value, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF7C86A2),
                fontWeight: FontWeight.w500,
              ),
            ),
            const Icon(Icons.calendar_today_outlined, color: Color(0xFF7C86A2), size: 20),
          ],
        ),
      ),
    );
  }
}
