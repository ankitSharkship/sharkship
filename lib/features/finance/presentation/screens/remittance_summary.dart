import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/finance/presentation/state/remittance_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/selected_rs_notifier.dart';
import 'package:sharkship/features/finance/presentation/widgets/rs_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/rs_header.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_stat_card.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/error_card.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class RemittanceSummary extends ConsumerStatefulWidget {
  const RemittanceSummary({super.key});

  @override
  ConsumerState<RemittanceSummary> createState() => _RemittanceSummaryState();
}

class _RemittanceSummaryState extends ConsumerState<RemittanceSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(child: Column(children: [RsHeader(), _buildBody()])),
    );
  }

  Widget _buildBody() {
    final remittanceAsync = ref.watch(remittanceProvider);
    final selectedRs = ref.watch(selectedRsProvider);

    return remittanceAsync.when(
      data: (remittanceState) {
        final cycles = remittanceState.cycles;
        final state = remittanceState.details;
        final isAllSelected = ref
            .read(selectedRsProvider.notifier)
            .isAllSelected();
        final items = [
          (
            "Total Remittance Paid",
            state?.totalRemittancePaid.toString() ?? "0",
            Icons.paid_outlined,
          ),
          (
            "Total COD Collected",
            state?.totalCodCollected?.toString() ?? "0",
            Icons.money,
          ),
          (
            "Remittance Due",
            state?.dueRemittance.toString() ?? "0",
            Icons.pending_actions_sharp,
          ),
          (
            "Upcoming Remittance",
            state?.upcomingRemittance.toString() ?? "0",
            Icons.calendar_month,
          ),
          (
            "Last Remittance",
            state?.lastRemittancePaid.toString() ?? "0",
            Icons.handshake_sharp,
          ),
        ];

        return Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final crossAxisCount = constraints.maxWidth > 600
                              ? 3
                              : 2;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  mainAxisExtent: 70,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemBuilder: (_, i) => ShipmentStatCard(
                              title: items[i].$1,
                              value: items[i].$2,
                              icon: items[i].$3,
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.lightBlueBg,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5,
                              ),
                              child: row(
                                "Holding Period",
                                state?.holdingPeriod.toString() ?? "0",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5,
                              ),
                              child: row(
                                "Holding Percentage",
                                state?.holdingPercentage.toString() ?? "0%",
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              if (remittanceState.isFiltering)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(child: ThreeDotsLoader()),
                  ),
                )
              else if (cycles.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "No records found",
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                )
              else ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      // vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isAllSelected,
                          onChanged: (val) {
                            ref.read(selectedRsProvider.notifier).toggleAll();
                          },
                          activeColor: AppColors.primaryBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          isAllSelected ? "Unselect All" : "Select All",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          "${selectedRs.selectedIds.length} Selected",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontSize: 12,
                                color: AppColors.primaryBlue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == cycles.length) {
                      return remittanceState.isLoadingMore
                          ? const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : const SizedBox.shrink();
                    }

                    // loadMore trigger
                    if (index == cycles.length - 1 &&
                        cycles.length < remittanceState.totalCount &&
                        !remittanceState.isLoadingMore) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ref.read(remittanceProvider.notifier).loadMore();
                      });
                    }

                    final remittance = cycles[index];
                    final isSelected = selectedRs.selectedIds.contains(
                      remittance.id,
                    );
                    return RsCard(
                      remittance: remittance,
                      isSelected: isSelected,
                      onSelected: (val) {
                        ref
                            .read(selectedRsProvider.notifier)
                            .toggle(remittance.id);
                      },
                      onMoreTap: () {},
                    );
                  }, childCount: cycles.length + 1),
                ),
              ],
            ],
          ),
        );
      },
      error: (err, stack) => Expanded(
        child: Center(
          child: ErrorCard(onRetry: () => ref.invalidate(remittanceProvider)),
        ),
      ),
      loading: () => const Expanded(child: Center(child: ThreeDotsLoader())),
    );
  }

  Widget row(
    String label,
    String value, {
    bool isMultiline = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: isMultiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                color: valueColor ?? Colors.grey.shade600,
                fontWeight: valueColor != null
                    ? FontWeight.bold
                    : FontWeight.w500,
              ),
              textAlign: TextAlign.end,
              maxLines: isMultiline ? 3 : 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
