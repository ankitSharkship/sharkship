import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';
import 'package:sharkship/features/tickets/domain/usecases/get_tickets_usecase.dart';

class TicketNotifier extends StateNotifier<AsyncValue<TicketListResponse>> {
  final GetTickets getTickets;
  TicketFilter filter;

  TicketNotifier(this.getTickets, this.filter) : super(const AsyncLoading()) {
    fetch();
  }

  Future<void> fetch({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        state = const AsyncLoading();
      }

      final result = await getTickets(filter);

      if (loadMore && state.value != null) {
        final old = state.value!;
        state = AsyncData(
          TicketListResponse(
            totalTickets: result.totalTickets,
            tickets: [...old.tickets, ...result.tickets],
          ),
        );
      } else {
        state = AsyncData(result);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  void nextPage() {
    filter = TicketFilter(
      total: filter.total,
      skip: filter.skip + filter.total,
      status: filter.status,
      category: filter.category,
    );

    fetch(loadMore: true);
  }
}
