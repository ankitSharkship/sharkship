import 'package:sharkship/features/tickets/data/datasources/tickets_remote_datasource.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket.dart';
import 'package:sharkship/features/tickets/domain/repositories/tickets_repository.dart';

class TicketsRepositoryImpl implements TicketsRepository {
  final TicketsRemoteDataSource remoteDataSource;

  TicketsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Ticket> createTicket({
    required String category,
    required String userNote,
  }) async {
    return await remoteDataSource.createTicket(
      category: category,
      userNote: userNote,
    );
  }

  @override
  Future<TicketListResponse> getTickets(TicketFilter filter) async {
    final responseModel = await remoteDataSource.getTickets(filter);
    return responseModel.toEntity();
  }
}
