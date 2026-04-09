import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/domain/entities/orders_response_entity.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
part 'selected_orders_notifier.g.dart';

class SelectedOrdersState {
  final Set<String> selectedIds;
  final bool isLoading;
  final String? message;

  const SelectedOrdersState({
    required this.selectedIds,
    required this.isLoading,
    this.message,
  });

  SelectedOrdersState copyWith({
    Set<String>? selectedIds,
    bool? isLoading,
    String? message,
  }) {
    return SelectedOrdersState(
      selectedIds: selectedIds ?? this.selectedIds,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}

@riverpod
class SelectedOrdersNotifier extends _$SelectedOrdersNotifier {
  @override
  SelectedOrdersState build(int tabIndex) {
    return const SelectedOrdersState(selectedIds: {}, isLoading: false);
  }

  void toggle(String id) {
    final current = state.selectedIds;

    if (current.contains(id)) {
      state = state.copyWith(selectedIds: {...current}..remove(id));
    } else {
      state = state.copyWith(selectedIds: {...current, id});
    }
  }

  void toggleAll(OrdersResponseEntity value) {
    final allIds = value.orders.map((e) => e.id.toString()).toSet();

    if (state.selectedIds.length == allIds.length) {
      state = state.copyWith(selectedIds: {});
    } else {
      state = state.copyWith(selectedIds: allIds);
    }
  }

  bool isAllSelected(OrdersResponseEntity value) {
    final total = value.orders.length;
    return state.selectedIds.isNotEmpty && state.selectedIds.length == total;
  }

  void clear() {
    state = state.copyWith(selectedIds: {});
  }

  Future<bool> deleteSelected() async {
    if (state.selectedIds.isEmpty) return false;
    final message = state.selectedIds.length > 1
        ? "Deleting orders..."
        : "Deleting order...";
    state = state.copyWith(isLoading: true, message: message);

    try {
      await ref.read(deleteOrdersUseCaseProvider).execute({
        "order_ids": state.selectedIds.toList(),
      });
      await Future.delayed(const Duration(seconds: 2));
      // Clear selection after success
      state = state.copyWith(selectedIds: {}, isLoading: false, message: null);
      print(state.selectedIds);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow; // don't swallow errors silently
    }
  }
}
