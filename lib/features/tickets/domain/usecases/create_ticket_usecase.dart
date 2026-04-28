import 'package:sharkship/features/tickets/domain/entities/ticket.dart';
import 'package:sharkship/features/tickets/domain/repositories/tickets_repository.dart';

class CreateTicketUseCase {
  final TicketsRepository repository;

  CreateTicketUseCase(this.repository);

  Future<Ticket> call({
    required String category,
    required String userNote,
  }) async {
    return await repository.createTicket(
      category: category,
      userNote: userNote,
    );
  }
}
