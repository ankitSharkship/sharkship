import 'package:sharkship/features/tickets/data/datasources/tikcet_remote_datasource.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';
import 'package:sharkship/features/tickets/domain/repository/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remote;

  TicketRepositoryImpl(this.remote);

  @override
  Future<TicketListResponse> getTickets(TicketFilter filter) async {
    final result = await remote.getTickets(filter);
    return result.toEntity();
  }
}
