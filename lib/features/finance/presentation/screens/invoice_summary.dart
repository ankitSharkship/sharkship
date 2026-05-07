import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/finance/presentation/state/is_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/widgets/is_header.dart';
import 'package:sharkship/features/finance/presentation/widgets/is_tabbar.dart';
import 'package:sharkship/features/finance/presentation/widgets/otp_bottom_sheet.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/features/finance/presentation/state/invoices_summary_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/selected_is_notifier.dart';
import 'package:sharkship/features/finance/presentation/widgets/invoice_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/cn_invoice_card.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/features/finance/domain/entities/tax_invoice_entity.dart';
import 'package:sharkship/features/finance/domain/entities/cn_invoice_entity.dart';
import 'package:sharkship/shared/widgets/error_card.dart';

class InvoiceSummary extends ConsumerStatefulWidget {
  const InvoiceSummary({super.key});

  @override
  ConsumerState<InvoiceSummary> createState() => _InvoiceSummaryState();
}

class _InvoiceSummaryState extends ConsumerState<InvoiceSummary> {
  Future<void> _onRefresh() async {
    final selectedTab = ref.read(isTabProvider);
    ref.invalidate(taxInvoicesProvider(selectedTab));
  }

  Future<void> initiateOtp(
    BuildContext context,
    String invoiceId,
    bool isPdf,
  ) async {
    final selectedTab = ref.read(isTabProvider);
    final messenger = ScaffoldMessenger.of(context);

    final controller = messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(days: 1),
        content: StatusNotification(
          message: "Sending OTP",
          status: StatusType.loading,
        ),
      ),
    );

    try {
      final result = await ref
          .read(taxInvoicesProvider(selectedTab).notifier)
          .initiateOTP(selectedTab);

      controller.close();

      if (!result) {
        if (!context.mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Failed to download')),
        );
        return;
      }

      if (!context.mounted) return;

      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.scaffoldBg,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) => OtpBottomSheet(
          title: "Enter OTP",
          onVerify: (otp) async {
            final isTax = selectedTab == 0;

            return await ref
                .read(taxInvoicesProvider(selectedTab).notifier)
                .verifySingle(isPdf, invoiceId, isTax, otp);
          },
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
            message: 'Failed to send OTP: ${e.toString()}',
            status: StatusType.error,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(isTabProvider);
    final stateAsync = ref.watch(taxInvoicesProvider(selectedTab));
    final selectedInvoices = ref.watch(selectedIsProvider(selectedTab));

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const IsHeader(),
            IsTabbar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: stateAsync.when(
                  loading: () => const OrdersSkeletonList(),
                  error: (err, st) => Center(
                    child: ErrorCard(
                      onRetry: () =>
                          ref.invalidate(taxInvoicesProvider(selectedTab)),
                    ),
                  ),
                  data: (state) {
                    final invoices = selectedTab == 0
                        ? (state.taxInvoices ?? [])
                        : (state.cnInvoices ?? []);

                    if (state.isLoading) return const OrdersSkeletonList();

                    if (invoices.isEmpty) {
                      return const Center(child: Text('No Invoices found'));
                    }

                    final isAllSelected = ref
                        .read(selectedIsProvider(selectedTab).notifier)
                        .isAllSelected(selectedTab);

                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        // Select All Header
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isAllSelected,
                                  onChanged: (val) {
                                    ref
                                        .read(
                                          selectedIsProvider(
                                            selectedTab,
                                          ).notifier,
                                        )
                                        .toggleAll(selectedTab);
                                  },
                                  activeColor: const Color(0xFF0084FF),
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
                                  "${selectedInvoices.selectedIds.length} Selected",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        fontSize: 12,
                                        color: const Color(0xFF0084FF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // List of Cards
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            if (index == invoices.length - 1 &&
                                invoices.length < state.totalCount) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                ref
                                    .read(
                                      taxInvoicesProvider(selectedTab).notifier,
                                    )
                                    .loadMore();
                              });
                            }

                            if (index >= invoices.length) {
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

                            final invoice = invoices[index];
                            final id = (invoice is TaxInvoiceEntity)
                                ? invoice.id.toString()
                                : (invoice as CnInvoiceEntity).id.toString();

                            final isSelected = selectedInvoices.selectedIds
                                .contains(id);

                            return RepaintBoundary(
                              child: invoice is TaxInvoiceEntity
                                  ? InvoiceCard(
                                      invoice: invoice,
                                      isSelected: isSelected,
                                      onSelected: (val) {
                                        ref
                                            .read(
                                              selectedIsProvider(
                                                selectedTab,
                                              ).notifier,
                                            )
                                            .toggle(id);
                                      },
                                      onPdfTap: () {
                                        initiateOtp(context, id, true);
                                      },
                                      onExcelTap: () {
                                        initiateOtp(context, id, false);
                                      },
                                    )
                                  : CnInvoiceCard(
                                      invoice: invoice as CnInvoiceEntity,
                                      isSelected: isSelected,
                                      onSelected: (val) {
                                        ref
                                            .read(
                                              selectedIsProvider(
                                                selectedTab,
                                              ).notifier,
                                            )
                                            .toggle(id);
                                      },
                                      onPdfTap: () {
                                        initiateOtp(context, id, true);
                                      },
                                      onExcelTap: () {
                                        initiateOtp(context, id, false);
                                      },
                                    ),
                            );
                          }, childCount: invoices.length + 1),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 20)),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
