import 'package:sharkship/features/tickets/data/model/ticket_model.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';

abstract class TicketRemoteDataSource {
  Future<TicketListResponseModel> getTickets(TicketFilter filter);
}
