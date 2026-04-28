import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_providers.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_tab_provider.dart';
import 'package:sharkship/features/tickets/presentation/state/tickets_filters_tab_provider.dart';
import 'package:sharkship/features/home/presentation/state/dashboard_notifier.dart';

part 'tickets_notifier.g.dart';

class TicketsState {
  final TicketListResponse? data;
  final bool isLoading;
  final bool isLoadingMore;
  final bool isFiltering;
  final Object? error;

  TicketsState({
    this.data,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isFiltering = false,
    this.error,
  });

  TicketsState copyWith({
    TicketListResponse? data,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isFiltering,
    Object? error,
  }) {
    return TicketsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFiltering: isFiltering ?? this.isFiltering,
      error: error,
    );
  }
}

@riverpod
class TicketsNotifier extends _$TicketsNotifier {
  @override
  Future<TicketsState> build(int tabIndex) async {
    ref.watch(dashboardDateProvider);

    final params = _buildParams();
    final response = await _fetchTickets(params);

    return TicketsState(data: response);
  }

  Future<TicketListResponse> _fetchTickets(TicketFilter filter) async {
    return await ref.read(getTicketsUseCaseProvider).call(filter);
  }

  Future<void> applyFilters() async {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isFiltering: true));

    try {
      final params = _buildParams();
      final response = await _fetchTickets(params);
      state = AsyncData(TicketsState(data: response));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || current.data == null)
      return;

    final totalCount = current.data!.totalTickets;
    final currentCount = current.data!.tickets.length;

    if (currentCount >= totalCount) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final params = _buildParams().copyWith(skip: currentCount, total: 10);

      final newResponse = await _fetchTickets(params);

      final updated = TicketListResponse(
        totalTickets: newResponse.totalTickets,
        tickets: [...current.data!.tickets, ...newResponse.tickets],
      );

      state = AsyncData(current.copyWith(data: updated, isLoadingMore: false));
    } catch (e, st) {
      state = AsyncData(current.copyWith(isLoadingMore: false, error: e));
    }
  }

  TicketFilter _buildParams() {
    final category = ref.read(ticketsCategoryTypeFilterProvider);
    final selectedTab = ref.read(ticketsTabProvider);
    final dateRange = ref.read(dashboardDateProvider);

    // Force start of day (00:00:00) and end of day (23:59:59)
    final start = DateTime(
      dateRange.start.year,
      dateRange.start.month,
      dateRange.start.day,
      0,
      0,
      0,
    );
    final end = DateTime(
      dateRange.end.year,
      dateRange.end.month,
      dateRange.end.day,
      23,
      59,
      59,
    );

    return TicketFilter(
      total: 10,
      skip: 0,
      category: (category == null || category == "All") ? "" : category,
      status: _getStatus(selectedTab),
      startDate: start,
      endDate: end,
    );
  }

  String? _getStatus(int tabIndex) {
    switch (tabIndex) {
      case 0:
        return "PENDING";
      case 1:
        return "RESOLVED";
      case 2:
        return "REJECTED";
      case 3:
        return "INITIATED";
      default:
        return "PENDING";
    }
  }

  Future<void> createTicket({
    required String category,
    required String userNote,
    void Function(String message)? onSuccess,
  }) async {
    // We don't set state = const AsyncLoading() here because it would
    // destroy the current list state in the background.
    // Instead, the UI should show a loading overlay if needed.
    try {
      final ticket = await ref
          .read(createTicketUseCaseProvider)
          .call(category: category, userNote: userNote);

      onSuccess?.call(ticket.message ?? "Ticket sent");

      // Refresh state after creation
      ref.invalidateSelf();
    } catch (e, st) {
      // If we want to show error on the list
      // state = AsyncError(e, st);
      rethrow;
    }
  }
}

extension TicketFilterExtension on TicketFilter {
  TicketFilter copyWith({
    int? total,
    int? skip,
    String? status,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return TicketFilter(
      total: total ?? this.total,
      skip: skip ?? this.skip,
      status: status ?? this.status,
      category: category ?? this.category,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
