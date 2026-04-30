import 'package:sharkship/features/tickets/domain/entities/ticket.dart';

abstract class TicketsRepository {
  Future<Ticket> createTicket({
    required String category,
    required String userNote,
  });

  Future<TicketListResponse> getTickets(TicketFilter filter);
}
