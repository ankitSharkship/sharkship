import 'package:sharkship/features/tickets/domain/entities/ticket.dart';
import 'package:sharkship/features/tickets/domain/repositories/tickets_repository.dart';

class GetTicketsUseCase {
  final TicketsRepository repository;

  GetTicketsUseCase(this.repository);

  Future<TicketListResponse> call(TicketFilter filter) async {
    return await repository.getTickets(filter);
  }
}
