import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sharkship/features/finance/presentation/state/selected_ts_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/transactions_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/ts_filters_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/state/ts_tab_provider.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';
import 'package:sharkship/features/home/presentation/widgets/date_range_picker_modal.dart';
import 'package:sharkship/features/finance/presentation/state/finance_filter_models.dart';

class TsHeader extends ConsumerWidget {
  const TsHeader({super.key});

  void _showDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DateRangePickerModal(),
    );
  }

  void _showActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _actionsBottomDrawer(context, ref),
    );
  }

  void _showFilter(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _filterBottomDrawer(context, ref),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 8, top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 28),
              ),
              const Text(
                "Transactions Summary",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => _showDatePicker(context),
                icon: const Icon(Icons.calendar_month_outlined, size: 28),
              ),
              IconButton(
                onPressed: () => _showActions(context, ref),
                icon: const Icon(Icons.build, size: 22),
              ),
              IconButton(
                onPressed: () => _showFilter(context, ref),
                icon: const Icon(Icons.filter_alt, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterBottomDrawer(BuildContext context, WidgetRef ref) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,

      decoration: const BoxDecoration(
        color: Color(0xFFDCE6ED),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // title
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
              child: Row(
                children: const [
                  Icon(Icons.filter_alt, size: 24),
                  SizedBox(width: 12),
                  Text(
                    "Filter Options",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(height: 1),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LeftTabs(),
                  const VerticalDivider(width: 1),
                  const Expanded(child: _RightContent()),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final selectedTab = ref.read(tsTabProvider);
                      final dashboardDate = ref.read(dashboardDateProvider);
                      final walletType = ref.read(tsWalletTypeFilterProvider);
                      final orderDesc = ref.read(tsOrderDescTypeFilterProvider);
                      final journeyType = ref.read(tsJourneyTypeFilterProvider);
                      final txnType = ref.read(tsTxnTypeFilterProvider);
                      final searchState = ref.read(tsSearchProvider);
                      String? orderId;
                      String? trackingId;
                      String? paymentGatewayId;

                      if (searchState.active && searchState.value.isNotEmpty) {
                        if (searchState.type == SearchType.orderId) {
                          orderId = searchState.value;
                          trackingId = "";
                          paymentGatewayId = "";
                        } else if (searchState.type == SearchType.trackingId) {
                          trackingId = searchState.value;
                          orderId = "";
                          paymentGatewayId = "";
                        } else if (searchState.type == SearchType.txnId) {
                          paymentGatewayId = searchState.value;
                          orderId = "";
                          trackingId = "";
                        }
                      }

                      final params = TransactionsParams(
                        total: 10,
                        skip: 0,
                        startDate: dashboardDate.start.toIso8601String(),
                        endDate: dashboardDate.end.toIso8601String(),
                        isWallet: ref
                            .read(transactionsProvider(selectedTab).notifier)
                            .getWalletStatus(selectedTab),
                        isFilter: true,
                        transactionCategory: orderDesc == "All"
                            ? null
                            : orderDesc,
                        journeyType: journeyType == "All" ? null : journeyType,
                        transactionType: txnType == "All" ? null : txnType,
                        affectedBalance: walletType == "All"
                            ? null
                            : walletType,
                        orderId: orderId,
                        trackingId: trackingId,
                        paymentGatewayId: paymentGatewayId,
                      );

                      ref
                          .read(transactionsProvider(selectedTab).notifier)
                          .fetchTransactions(params, selectedTab);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Color(0xFF0084FF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionsBottomDrawer(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(tsTabProvider);
    final selectedTss = ref.watch(selectedTsProvider(selectedTab));

    Future<void> exportOrders(BuildContext context, WidgetRef ref) async {
      Navigator.pop(context);

      final messenger = ScaffoldMessenger.of(context);

      // 1. Show Loading
      final controller = messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          duration: const Duration(days: 1),
          content: StatusNotification(
            message: selectedTss.message ?? "Exporting Transactions",
            status: StatusType.loading,
          ),
        ),
      );

      try {
        await ref
            .read(selectedTsProvider(selectedTab).notifier)
            .exportOrders(selectedTab);

        controller.close();

        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: 'Transactions Exported successfully',
              status: StatusType.success,
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
              message: 'Failed to export transactions: ${e.toString()}',
              status: StatusType.error,
            ),
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFDCE6ED),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            // title
            Row(
              children: const [
                Icon(Icons.build, size: 23),
                SizedBox(width: 8),
                Text(
                  "Actions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // card container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: "Export Orders",
                          icon: Icons.upload_outlined,
                          color: Colors.grey,
                          enabled: selectedTss.selectedIds.isNotEmpty,
                          onTap: () {
                            exportOrders(context, ref);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool enabled;
  final VoidCallback? onTap;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = enabled ? color : color.withValues(alpha: 0.3);

    return OutlinedButton.icon(
      onPressed: enabled ? onTap : null,
      icon: Icon(icon, color: effectiveColor),
      label: Text(label, style: TextStyle(color: effectiveColor)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: effectiveColor, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

class _LeftTabs extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTsFilterTabProvider);

    return SingleChildScrollView(
      child: SizedBox(
        width: 140,
        child: Column(
          children: TsFilterTab.values.map((tab) {
            final isSelected = tab == selectedTab;

            return GestureDetector(
              onTap: () {
                ref.read(selectedTsFilterTabProvider.notifier).state = tab;
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  top: 12,
                  bottom: 12,
                  left: 20,
                  right: 5,
                ),
                color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                child: Text(
                  _getLabel(tab),
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _getLabel(TsFilterTab tab) {
    switch (tab) {
      case TsFilterTab.journeyType:
        return "Journey Type";
      case TsFilterTab.orderDescType:
        return "Order Desc";
      case TsFilterTab.txnType:
        return "Txn Type";
      case TsFilterTab.walletType:
        return "Wallet Type";
    }
  }
}

class _RightContent extends ConsumerWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTsFilterTabProvider);

    switch (selectedTab) {
      case TsFilterTab.journeyType:
        return _JourneyTypeView();
      case TsFilterTab.orderDescType:
        return _OrderDescView();
      case TsFilterTab.txnType:
        return _TxnTypeView();
      case TsFilterTab.walletType:
        return _WalletTypeView();
      default:
        return SizedBox.shrink();
    }
  }
}

class _JourneyTypeView extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Forward", value: "FORWARD"),
    RadioItems(displayName: "Reverse", value: "REVERSE"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(tsJourneyTypeFilterProvider);
    return _buildRadioList(ref, tsJourneyTypeFilterProvider, items, selected);
  }
}

class _OrderDescView extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Shipping Charge", value: "SHIPPING_CHARGE"),
    RadioItems(displayName: "Discrepency Charge", value: "DISCREPENCY_CHARGE"),
    RadioItems(displayName: "Cash Collected", value: "CASH_COLLECTED"),
    RadioItems(
      displayName: "Amount Deducted Against Order",
      value: "AMOUNT_DEDUCTED_AGAINST_ORDER",
    ),
    RadioItems(
      displayName: "Refund Against Order Cancellation",
      value: "REFUND_AGAINST_ORDER_CANCELLATION",
    ),
    RadioItems(
      displayName: "Amount Deducted Against Return",
      value: "AMOUNT_DEDUCTED_AGAINST_RETURN",
    ),
    RadioItems(
      displayName: "Amount Deducted Against Weight Dispute",
      value: "AMOUNT_DEDUCTED_AGAINST_WEIGHT_DISPUTE",
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(tsOrderDescTypeFilterProvider);
    return _buildRadioList(ref, tsOrderDescTypeFilterProvider, items, selected);
  }
}

class _TxnTypeView extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Credit", value: "CREDIT"),
    RadioItems(displayName: "Debit", value: "DEBIT"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(tsTxnTypeFilterProvider);
    return _buildRadioList(ref, tsTxnTypeFilterProvider, items, selected);
  }
}

class _WalletTypeView extends ConsumerWidget {
  final items = [
    RadioItems(displayName: "All", value: "All"),
    RadioItems(displayName: "Cash", value: "CASH"),
    RadioItems(displayName: "Credit", value: "CREDIT"),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(tsWalletTypeFilterProvider);
    return _buildRadioList(ref, tsWalletTypeFilterProvider, items, selected);
  }
}

Widget _buildRadioList(
  WidgetRef ref,
  StateProvider<String?> provider,
  List<RadioItems> items,
  String? selected,
) {
  return ListView.builder(
    itemCount: items.length,
    padding: const EdgeInsets.symmetric(vertical: 8),
    itemBuilder: (context, index) {
      final item = items[index];
      return RadioListTile<String>(
        value: item.value,
        groupValue: selected ?? "All",
        title: Text(item.displayName, style: const TextStyle(fontSize: 14)),
        dense: true,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Colors.blue,
        onChanged: (val) {
          ref.read(provider.notifier).state = val;
        },
      );
    },
  );
}

enum StatusType { loading, success, error, deleteLoading }

class StatusNotification extends StatelessWidget {
  final String message;
  final StatusType status;
  const StatusNotification({required this.message, required this.status});

  @override
  Widget build(BuildContext context) {
    Color themeColor;
    Color bgColor;
    Widget icon;

    switch (status) {
      case StatusType.loading:
        themeColor = Colors.blue.shade700;
        bgColor = Colors.blue.shade50;
        icon = CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        );
        break;
      case StatusType.success:
        themeColor = const Color(0xFF2E7D32);
        bgColor = const Color(0xFFF0F9F4);
        icon = Icon(Icons.check_circle, color: themeColor, size: 28);
        break;
      case StatusType.error:
        themeColor = Colors.red.shade800;
        bgColor = Colors.red.shade50;
        icon = Icon(Icons.error, color: themeColor, size: 28);
        break;
      case StatusType.deleteLoading:
        themeColor = Colors.red.shade800;
        bgColor = Colors.red.shade50;
        icon = CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(themeColor),
        );
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: icon),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: themeColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
