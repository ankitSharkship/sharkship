import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/features/ndr/domain/entity/ndr_response_entity.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_notifier.dart';
import 'package:sharkship/features/ndr/presentation/state/ndr_tab_provider.dart';
import 'package:sharkship/features/ndr/presentation/state/selected_ndr_notifier.dart';
import 'package:sharkship/features/ndr/presentation/widgets/ndr_card.dart';
import 'package:sharkship/features/ndr/presentation/widgets/ndr_header.dart';
import 'package:sharkship/features/ndr/presentation/widgets/ndr_tabbar.dart';
import 'package:sharkship/features/orders/presentation/widgets/order_skeleton.dart';
import 'package:sharkship/shared/constants/app_colors.dart';
import 'package:sharkship/shared/constants/colors.dart';

class NdrScreen extends ConsumerStatefulWidget {
  const NdrScreen({super.key});

  @override
  ConsumerState<NdrScreen> createState() => _NdrScreenState();
}

class _NdrScreenState extends ConsumerState<NdrScreen> {
  final ScrollController _scrollController = ScrollController();

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
    final selectedTab = ref.read(ndrTabProvider);
    final state = ref.read(ndrProvider(selectedTab)).value;
    if (state == null || state.isLoadingMore || state.data == null) return;
    if (state.data!.orders.length >= state.data!.totalCount) return;
    ref.read(ndrProvider(selectedTab).notifier).loadMore();
  }

  Future<void> _onRefresh(int tab) async {
    ref.invalidate(ndrProvider(tab));
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(ndrTabProvider);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            const NdrHeader(),
            NdrTabbar(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedTab),
                backgroundColor: AppColors.lightBlue,
                color: Colors.white,
                child: _buildTabContent(selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int tab) {
    final ndrAsync = ref.watch(ndrProvider(tab));
    final selectedNdrs = ref.watch(selectedNdrProvider(tab));
    final selectedNdrNotifier = ref.read(selectedNdrProvider(tab).notifier);
    return ndrAsync.when(
      loading: () => const OrdersSkeletonList(itemCount: 6),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (state) {
        final data = state.data ?? NdrResponseEntity(totalCount: 0, orders: []);

        if (state.isFiltering) {
          return const Center(child: CircularProgressIndicator());
        }

        if (data.totalCount == 0) {
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
          itemCount: data.orders.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _header(data, selectedNdrNotifier);
            }

            final adjustedIndex = index - 1;

            if (adjustedIndex >= data.orders.length) {
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return const SizedBox.shrink();
            }

            final order = data.orders[adjustedIndex];
            final isSelected = selectedNdrs.selectedIds.contains(
              order.id.toString(),
            );
            return RepaintBoundary(
              child: NdrCard(
                order: order,
                isSelected: isSelected,
                onCheckboxChanged: (value) {
                  selectedNdrNotifier.toggle(order.id.toString());
                },
                isFailed: false,
                tab: tab,
                onDownloadTap: () {
                  _handleSingleReattempt(context, ref, order.id.toString());
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _handleSingleReattempt(
    BuildContext context,
    WidgetRef ref,
    String orderId,
  ) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      helpText: 'Select Re-attempt Date',
      confirmText: 'Confirm',
      cancelText: 'Cancel',
    );

    if (selectedDate == null) return;

    if (!context.mounted) return;

    final selectedTab = ref.read(ndrTabProvider);
    final messenger = ScaffoldMessenger.of(context);

    // Show Loading
    final controller = messenger.showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(days: 1),
        content: StatusNotification(
          message: "Scheduling Re-attempt",
          status: StatusType.loading,
        ),
      ),
    );

    try {
      final success = await ref
          .read(selectedNdrProvider(selectedTab).notifier)
          .reattempt(selectedDate.toUtc().toIso8601String(), ids: [orderId]);

      controller.close();

      if (success) {
        messenger.showSnackBar(
          SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: const StatusNotification(
              message: 'Re-attempt scheduled successfully',
              status: StatusType.success,
            ),
          ),
        );
        ref.invalidate(ndrProvider(selectedTab));
      }
    } catch (e) {
      controller.close();
      messenger.showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: StatusNotification(
            message: 'Failed to schedule re-attempt: ${e.toString()}',
            status: StatusType.error,
          ),
        ),
      );
    }
  }

  Widget _header(
    NdrResponseEntity data,
    SelectedNdrNotifier selectedNdrNNotifier,
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
          style: Theme.of(context).textTheme.bodyMedium,
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
          'No NDR Orders',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.secondaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'All shipments are on track.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
