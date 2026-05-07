import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/businessTools/presentation/state/reports_notifier.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/gradient_button.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class GetOrdersMISReport extends ConsumerWidget {
  const GetOrdersMISReport({super.key});

  final List<String> statusOptions = const [
    'All Status',
    'To Be Processed',
    'Shipped',
    'Out For Delivery',
    'Delivered',
    'Ready To Ship',
    'Cancelled',
    'Returned',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsState = ref.watch(reportsProvider);

    return reportsState.when(
      loading: () => const Center(child: ThreeDotsLoader()),
      error: (error, stack) => Center(
        child: Column(
          children: [
            Text('Something went wrong'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => ref.refresh(reportsProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  // A negative spreadRadius hides the shadow on the top and sides
                  spreadRadius: -1,
                  // Offset(x, y) - positive y moves it down
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Text(
                      'Get Orders MIS Report',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            // A negative spreadRadius hides the shadow on the top and sides
                            spreadRadius: -1,
                            // Offset(x, y) - positive y moves it down
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'i',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'This report will give you a detailed overview of the orders that have been placed on your account.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),

                // Start Date
                _buildDateField(
                  context,
                  ref,
                  label: 'Start Date',
                  value: state.startDate,
                  onTap: () => _selectStartDate(context, ref, state.startDate),
                ),
                const SizedBox(height: 24),

                // End Date
                _buildDateField(
                  context,
                  ref,
                  label: 'End Date',
                  value: state.endDate,
                  onTap: () => _selectEndDate(context, ref, state.endDate),
                ),
                const SizedBox(height: 32),

                // Select Status
                _buildSectionTitle('Select Status', context),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        // A negative spreadRadius hides the shadow on the top and sides
                        spreadRadius: -1,
                        // Offset(x, y) - positive y moves it down
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _buildStatusChips(
                    ref,
                    state.selectedStatuses,
                    context,
                  ),
                ),

                const SizedBox(height: 32),

                // Select Carrier
                _buildSectionTitle('Select Carrier', context),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        // A negative spreadRadius hides the shadow on the top and sides
                        spreadRadius: -1,
                        // Offset(x, y) - positive y moves it down
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: _buildCarrierChips(
                    ref,
                    state.partners,
                    state.selectedPartners,
                    context,
                  ),
                ),
                const SizedBox(height: 40),

                // Generate Report Button
                GradientButton(
                  text: 'Download Report',
                  onTap: () => _handleGenerateReport(context, ref),
                  height: 48,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    WidgetRef ref, {
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' *',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value != null
                        ? _formatDate(value)
                        : 'Select ${label.toLowerCase()}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: value != null ? Colors.black : Colors.grey[500],
                    ),
                  ),
                  Icon(Icons.calendar_month, size: 20, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: ' *',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChips(
    WidgetRef ref,
    List<String> selectedStatuses,
    BuildContext context,
  ) {
    return Wrap(
      spacing: 4,
      runSpacing: 7,
      children: statusOptions.map((status) {
        final isSelected = selectedStatuses.contains(status);
        return GestureDetector(
          onTap: () {
            ref.read(reportsProvider.notifier).toggleStatus(status);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[50] : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.primaryBlue : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              status,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryBlue : Colors.grey[700],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCarrierChips(
    WidgetRef ref,
    List<String> partners,
    List<String> selectedPartners,
    BuildContext context,
  ) {
    final allPartners = ['All Carriers', ...partners];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: allPartners.map((partner) {
        final isSelected = selectedPartners.contains(partner);
        return GestureDetector(
          onTap: () {
            ref.read(reportsProvider.notifier).togglePartner(partner);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[50] : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.primaryBlue : Colors.grey[300]!,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              partner,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.primaryBlue : Colors.grey[700],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _selectStartDate(
    BuildContext context,
    WidgetRef ref,
    DateTime? current,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(reportsProvider.notifier).setStartDate(picked);
    }
  }

  Future<void> _selectEndDate(
    BuildContext context,
    WidgetRef ref,
    DateTime? current,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(reportsProvider.notifier).setEndDate(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _handleGenerateReport(BuildContext context, WidgetRef ref) async {
    final state = ref.read(reportsProvider).value;
    if (state == null) return;

    if (state.startDate == null || state.endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select both start and end dates'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (state.startDate!.isAfter(state.endDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Start date must be before end date'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Call the notifier to request the report
    await ref.read(reportsProvider.notifier).requestReport();

    // Check for errors after call
    final finalState = ref.read(reportsProvider);
    if (finalState.hasError) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(finalState.error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Report request submitted successfully',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: AppColors.lightGreen,
          ),
        );
      }
    }
  }
}
