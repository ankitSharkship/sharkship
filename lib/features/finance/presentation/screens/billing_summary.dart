import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/charts/widgets/base_chart_card.dart';
import 'package:sharkship/features/finance/presentation/state/billing_summary_notifier.dart';
import 'package:sharkship/features/finance/presentation/widgets/billing_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/bs_grid_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/bs_header.dart';
import 'package:sharkship/features/finance/presentation/widgets/invoice_card.dart';
import 'package:sharkship/features/home/presentation/widgets/shipment_stat_card.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/widgets/error_card.dart';

class BillingSummary extends ConsumerStatefulWidget {
  const BillingSummary({super.key});

  @override
  ConsumerState<BillingSummary> createState() => _BillingSummaryState();
}

class _BillingSummaryState extends ConsumerState<BillingSummary> {
  Future<void> _onRefresh() async {
    await ref.read(billingSummaryProvider.notifier).refresh();
  }

  Future<void> _downloadSheet(String id) async {
    final messenger = ScaffoldMessenger.of(context);
    final controller = messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(days: 1),
        content: StatusNotification(
          message: "Downloading Sheet...",
          status: StatusType.loading,
        ),
      ),
    );

    try {
      final result = await ref
          .read(billingSummaryProvider.notifier)
          .downloadBillingSheet(id);
      controller.close();
      result.fold(
        (l) => messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: StatusNotification(
              message: "Download Failed: ${l.message}",
              status: StatusType.error,
            ),
          ),
        ),
        (r) => messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: "Downloaded Successfully",
              status: StatusType.success,
            ),
          ),
        ),
      );
    } catch (e) {
      controller.close();
      messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: StatusNotification(
            message: "Download Failed: $e",
            status: StatusType.error,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(billingSummaryProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const BsHeader(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(),
                child: stateAsync.when(
                  data: (state) {
                    final billingsData = state.data;
                    final billings = billingsData?.billingCycles;
                    if (state.isLoading) return const OrdersSkeletonList();
                    final items = [
                      (
                        "Plan Name",
                        billingsData?.planDetails?.planName.toString() ?? "0",
                        Icons.add_box,
                      ),
                      (
                        "Billing Period",
                        billingsData?.planDetails?.billingPeriod.toString() ??
                            "0",
                        Icons.calendar_month_outlined,
                      ),
                      (
                        "Credit Period",
                        billingsData?.planDetails?.creditPeriod.toString() ??
                            "0",
                        Icons.calendar_month_outlined,
                      ),
                    ];

                    if (billingsData == null || billings == null) {
                      return const Center(child: Text('No Billings found'));
                    }
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: BaseChartCard(
                              title: "Postpaid Plan Details",
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Column(
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: items.length,

                                        itemBuilder: (_, i) => Padding(
                                          padding: EdgeInsets.only(
                                            bottom: i == items.length - 1
                                                ? 0
                                                : 12,
                                          ),
                                          child: BSStatCard(
                                            title: items[i].$1,
                                            value: items[i].$2,
                                            icon: items[i].$3,
                                            onTap: () {},
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            if (index == billings.length - 1 &&
                                billings.length < billingsData.totalCount) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ref
                                    .read(billingSummaryProvider.notifier)
                                    .loadMore();
                              });
                            }
                            if (index >= billings.length) {
                              if (state.isLoadingMore) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }
                            final billing = billings[index];
                            return RepaintBoundary(
                              child: BillingCard(
                                billing: billing,
                                count: index,
                                onPdfTap: () => _downloadSheet(billing.id),
                              ),
                            );
                          }, childCount: billings.length + 1),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                      ],
                    );
                  },
                  loading: () => const OrdersSkeletonList(),
                  error: (err, st) => Center(
                    child: ErrorCard(
                      onRetry: () => ref.invalidate(billingSummaryProvider),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
