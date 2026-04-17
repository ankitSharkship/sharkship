import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/features/weightDiscrepency/domain/entities/wd_response_entity.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/selected_wd_notifier.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_notifier.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/state/wd_tab_provider.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/widgets/wd_card.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/widgets/wd_header.dart';
import 'package:sharkship/features/weightDiscrepency/presentation/widgets/wd_tabbar.dart';
import 'package:sharkship/shared/constants/colors.dart';

class WeightDiscrepancy extends ConsumerStatefulWidget {
  const WeightDiscrepancy({super.key});

  @override
  ConsumerState<WeightDiscrepancy> createState() => _WeightDiscrepancyState();
}

class _WeightDiscrepancyState extends ConsumerState<WeightDiscrepancy> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final selectedTab = ref.read(wdTabProvider);
      ref.read(wdProvider(selectedTab).notifier).loadMore();
    }
  }

  Future<void> _onRefresh(int tab) async {
    await ref.read(wdProvider(tab).notifier).applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(wdTabProvider);
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const WdHeader(),
            WdTabbar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedTab),
                child: _buildTabContent(selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tab) {
    final wdAsync = ref.watch(wdProvider(tab));
    final selectedWds = ref.watch(selectedWdProvider(tab));
    final selectedWdNotifier = ref.read(selectedWdProvider(tab).notifier);
    return wdAsync.when(
      loading: () => const OrdersSkeletonList(itemCount: 6),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (state) {
        final data = state.data;

        if (state.isFiltering) {
          return const Center(child: CircularProgressIndicator());
        }

        if (data == null || data.items.isEmpty) {
          return ListView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [const SizedBox(height: 100), _emptyState()],
          );
        }

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: data.items.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _header(data, selectedWdNotifier);
            }
            final adjustedIndex = index - 1;
            if (adjustedIndex >= data.items.length) {
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox(height: 80); // Bottom padding
            }

            final order = data.items[adjustedIndex];
            final isSelected = selectedWds.selectedIds.contains(
              order.id.toString(),
            );
            return RepaintBoundary(
              child: WdCard(
                order: order,
                isSelected: isSelected,
                onCheckboxChanged: (value) {
                  print(value);
                  selectedWdNotifier.toggle(order.id.toString());
                },
                isFailed: false,
                tab: tab,
              ),
            );
          },
        );
      },
    );
  }

  Widget _header(
    WdResponseEntity data,
    SelectedWdNotifier selectedNdrNNotifier,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: selectedNdrNNotifier.isAllSelected(data),
          onChanged: (value) {
            selectedNdrNNotifier.toggleAll(data);
          },
        ),
        const SizedBox(width: 4),
        Text(
          // isAllSelected ? "Unselect All" :
          !selectedNdrNNotifier.isAllSelected(data)
              ? "Select All"
              : "Unselect All",
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.local_shipping_outlined, size: 80, color: Colors.grey[300]),
        const SizedBox(height: 16),
        Text(
          'No Disputed Orders',
          style: TextStyle(
            fontSize: 20,
            color: ColorManager.secondaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'All shipments are on track.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
