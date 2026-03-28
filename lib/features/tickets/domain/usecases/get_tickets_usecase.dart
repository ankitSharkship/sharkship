import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';
import 'package:sharkship/features/tickets/domain/repository/ticket_repository.dart';

class GetTickets {
  final TicketRepository repository;

  GetTickets(this.repository);

  Future<TicketListResponse> call(TicketFilter filter) {
    return repository.getTickets(filter);
  }
}
