import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';

abstract class TicketRepository {
  Future<TicketListResponse> getTickets(TicketFilter filter);
}
