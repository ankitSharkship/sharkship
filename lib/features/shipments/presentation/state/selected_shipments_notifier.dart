import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/domain/entities/orders_response_entity.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
part 'selected_shipments_notifier.g.dart';

class SelectedShipmentsState {
  final Set<String> selectedIds;
  final bool isLoading;
  final String? message;

  const SelectedShipmentsState({
    required this.selectedIds,
    required this.isLoading,
    this.message,
  });

  SelectedShipmentsState copyWith({
    Set<String>? selectedIds,
    bool? isLoading,
    String? message,
  }) {
    return SelectedShipmentsState(
      selectedIds: selectedIds ?? this.selectedIds,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
    );
  }
}

@riverpod
class SelectedShipmentsNotifier extends _$SelectedShipmentsNotifier {
  @override
  SelectedShipmentsState build(int index) {
    return const SelectedShipmentsState(selectedIds: {}, isLoading: false);
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

  Future<bool> downloadLabels([List<int>? customIds]) async {
    final idsToDownload =
        customIds ?? state.selectedIds.map((e) => int.parse(e)).toList();
    if (idsToDownload.isEmpty) return false;

    state = state.copyWith(isLoading: true, message: null);
    try {
      await ref
          .read(downloadShippingLabelUseCaseProvider)
          .execute(idsToDownload);
      state = state.copyWith(
        isLoading: false,
        selectedIds: customIds == null ? {} : state.selectedIds,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, message: e.toString());
      return false;
    }
  }

  Future<bool> exportOrders() async {
    if (state.selectedIds.isEmpty) return false;
    final message = state.selectedIds.length > 1
        ? "Exporting orders..."
        : "Exporting order...";
    state = state.copyWith(isLoading: true, message: message);
    try {
      final selectedIds = state.selectedIds.map((e) => int.parse(e));
      await ref.read(exportOrdersUseCaseProvider).execute(selectedIds.toList());
      state = state.copyWith(selectedIds: {}, isLoading: false, message: null);
      print(state.selectedIds);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow; // don't swallow errors silently
    }
  }
}
