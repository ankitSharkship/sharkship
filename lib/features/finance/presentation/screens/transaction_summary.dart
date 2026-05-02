import 'package:flutter/material.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/finance/domain/entities/message_metrics_entity.dart';
import 'package:sharkship/features/finance/presentation/state/selected_ts_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/transactions_notifier.dart';
import 'package:sharkship/features/finance/presentation/state/ts_filters_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/state/ts_tab_provider.dart';
import 'package:sharkship/features/finance/presentation/widgets/messages_metrics_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/ts_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/ts_header.dart';
import 'package:sharkship/features/finance/presentation/widgets/ts_mssg_card.dart';
import 'package:sharkship/features/finance/presentation/widgets/ts_tabbar.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/shared/widgets/loader.dart';

class TransactionSummary extends ConsumerStatefulWidget {
  const TransactionSummary({super.key});

  @override
  ConsumerState<TransactionSummary> createState() => _TransactionSummaryState();
}

class _TransactionSummaryState extends ConsumerState<TransactionSummary> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    final selectedTab = ref.read(tsTabProvider);
    final state = ref.read(transactionsProvider(selectedTab)).value;
    if (state == null || state.isLoadingMore) return;

    if (selectedTab == 0 || selectedTab == 1) {
      final data = state.data;
      if (data == null || data.transactions.length >= data.totalCount) return;
    } else {
      final data = state.messageTransactions;
      if (data == null || data.transactions.length >= data.totalCount) return;
    }

    ref.read(transactionsProvider(selectedTab).notifier).loadMore();
  }

  Future<void> _onRefresh() async {
    ref.invalidate(transactionsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(tsTabProvider);

    ref.listen<SearchState>(tsSearchProvider, (previous, next) {
      if (next.value.isEmpty && controller.text.isNotEmpty) {
        controller.clear();
      }
    });

    final searchState = ref.watch(tsSearchProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const TsHeader(),
            TsTabbar(),

            if (selectedTab == 0 || selectedTab == 1) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Dropdown
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<SearchType>(
                            value: selectedTab == 1
                                ? SearchType.txnId
                                : (searchState.type == SearchType.txnId
                                      ? SearchType.orderId
                                      : searchState.type),
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primaryBlue,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                            items: selectedTab == 0
                                ? const [
                                    DropdownMenuItem(
                                      value: SearchType.orderId,
                                      child: Text('Order ID'),
                                    ),
                                    DropdownMenuItem(
                                      value: SearchType.trackingId,
                                      child: Text('Tracking ID'),
                                    ),
                                  ]
                                : const [
                                    DropdownMenuItem(
                                      value: SearchType.txnId,
                                      child: Text('Txn ID'),
                                    ),
                                  ],
                            onChanged: (value) {
                              if (value == null) return;
                              // controller.clear();
                              ref
                                  .read(tsSearchProvider.notifier)
                                  .state = searchState.copyWith(
                                type: value,
                                value: '',
                                active: false,
                              );
                            },
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 1,
                        indent: 12,
                        endIndent: 12,
                        color: Colors.black12,
                      ),
                      // Text field
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: controller,
                            onChanged: (value) {
                              final val = controller.text.trim();
                              if (val.isEmpty) {
                                ref
                                    .read(tsSearchProvider.notifier)
                                    .state = searchState.copyWith(
                                  active: false,
                                  value: '',
                                );
                              } else {
                                ref
                                    .read(tsSearchProvider.notifier)
                                    .state = searchState.copyWith(
                                  value: val,
                                  active: true,
                                );
                              }
                              // setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: selectedTab == 1
                                  ? 'Enter Txn ID'
                                  : (searchState.type == SearchType.orderId
                                        ? 'Enter Order ID'
                                        : 'Enter Tracking ID'),
                              hintStyle: Theme.of(context)
                                   .textTheme
                                   .bodySmall
                                   ?.copyWith(
                                     color: Colors.grey.shade400,
                                     fontSize: 14,
                                   ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              suffixIcon: controller.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        // controller.clear();
                                        ref
                                            .read(tsSearchProvider.notifier)
                                            .state = searchState.copyWith(
                                          active: false,
                                          value: '',
                                        );
                                        // setState(() {});
                                      },
                                    )
                                  : const Icon(
                                      Icons.search_rounded,
                                      color: AppColors.primaryBlue,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(),
                child: _buildTabContent(selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int selectedTab) {
    final tsAsync = ref.watch(transactionsProvider(selectedTab));
    final selectedTss = ref.watch(selectedTsProvider(selectedTab));

    return tsAsync.when(
      loading: () => const OrdersSkeletonList(),
      error: (err, st) => Center(child: Text('Error: ${err.toString()}')),
      data: (state) {
        switch (selectedTab) {
          case 0 || 1:
            final transactions = state.data?.transactions;

            if (state.isLoading) return const OrdersSkeletonList();

            if (transactions == null || transactions.isEmpty) {
              return const Center(child: Text('No Transactions found'));
            }

            final isAllSelected = ref
                .read(selectedTsProvider(selectedTab).notifier)
                .isAllSelected(selectedTab);
            if (state.isFiltering) {
              return const Center(child: CircularProgressIndicator());
            }
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Select All Header
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
                            ref
                                .read(selectedTsProvider(selectedTab).notifier)
                                .toggleAll(selectedTab);
                          },
                          activeColor: const Color(0xFF0084FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          isAllSelected ? "Unselect All" : "Select All",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          "${selectedTss.selectedIds.length} Selected",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0084FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // List of Cards
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index >= transactions.length) {
                      if (state.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const SizedBox.shrink();
                    }
                    final transaction = transactions[index];
                    final isSelected = selectedTss.selectedIds.contains(
                      transaction.id,
                    );

                    return RepaintBoundary(
                      child: TsCard(
                        selectedTab: selectedTab,
                        transaction: transaction,
                        isSelected: isSelected,
                        onSelected: (val) {
                          ref
                              .read(selectedTsProvider(selectedTab).notifier)
                              .toggle(transaction.id);
                        },
                      ),
                    );
                  }, childCount: transactions.length + 1),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          case 2:
            final transactions = state.messageTransactions?.transactions;
            final messageMetrics = state.messagesMetrics;
            if (state.isLoading) return const OrdersSkeletonList();
            if (transactions == null || transactions.isEmpty) {
              return const Center(child: Text('No Transactions found'));
            }
            final isAllSelected = ref
                .read(selectedTsProvider(selectedTab).notifier)
                .isAllSelected(selectedTab);
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                StatsGrid(data: messageMetrics),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isAllSelected,
                          onChanged: (val) {
                            ref
                                .read(selectedTsProvider(selectedTab).notifier)
                                .toggleAll(selectedTab);
                          },
                          activeColor: const Color(0xFF0084FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        Text(
                          isAllSelected ? "Unselect All" : "Select All",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          "${selectedTss.selectedIds.length} Selected",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0084FF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index >= transactions.length) {
                      if (state.isLoadingMore) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    final transaction = transactions[index];
                    final isSelected = selectedTss.selectedIds.contains(
                      transaction.id,
                    );

                    return TsMssgCard(
                      transaction: transaction,
                      isSelected: isSelected,
                      onSelected: (val) {
                        ref
                            .read(selectedTsProvider(selectedTab).notifier)
                            .toggle(transaction.id);
                      },
                      onMoreTap: () {},
                    );
                  }, childCount: transactions.length + 1),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            );
          default:
            return Column(children: [Center(child: ThreeDotsLoader())]);
        }
      },
    );
  }
}

class StatsGrid extends StatelessWidget {
  final MessageMetricsEntity? data;

  const StatsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatItem(
        title: "Processed",
        icon: Icons.sync_alt,
        count: data?.processedCount,
        amount: data?.processedTotalAmount,
      ),
      _StatItem(
        title: "Shipped",
        icon: Icons.local_shipping,
        count: data?.shippedCount,
        amount: data?.shippedTotalAmount,
      ),
      _StatItem(
        title: "OFD",
        icon: Icons.handyman,
        count: data?.outForDeliveryCount,
        amount: data?.outForDeliveryTotalAmount,
      ),
      _StatItem(
        title: "Delivered",
        icon: Icons.analytics,
        count: data?.deliveredCount,
        amount: data?.deliveredTotalAmount,
      ),
      _StatItem(
        title: "Return",
        icon: Icons.sync_alt,
        count: data?.returnedCount,
        amount: data?.returnedTotalAmount,
      ),
      _StatItem(
        title: "NDR",
        icon: Icons.local_shipping,
        count: data?.ndrCount,
        amount: data?.ndrTotalAmount,
      ),
      _StatItem(
        title: "Channel",
        icon: Icons.analytics,
        count: data?.channelCount,
        amount: data?.channelTotalAmount,
      ),
      _StatItem(
        title: "Manual",
        icon: Icons.handyman,
        count: data?.manualCount,
        amount: data?.manualTotalAmount,
      ),
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = items[index];

          return MessagesMetricsCard(
            title: item.title,
            icon: item.icon,
            count: item.count,
            amount: item.amount,
          );
        }, childCount: items.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
      ),
    );
  }
}

class _StatItem {
  final String title;
  final IconData icon;
  final String? count;
  final String? amount;

  _StatItem({
    required this.title,
    required this.icon,
    required this.count,
    required this.amount,
  });
}
