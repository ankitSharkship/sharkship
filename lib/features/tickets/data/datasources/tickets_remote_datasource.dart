import 'package:dio/dio.dart';
import 'package:sharkship/features/tickets/data/models/ticket_model.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket.dart';

abstract class TicketsRemoteDataSource {
  Future<TicketModel> createTicket({
    required String category,
    required String userNote,
  });

  Future<TicketListResponseModel> getTickets(TicketFilter filter);
}

class TicketsRemoteDataSourceImpl implements TicketsRemoteDataSource {
  final Dio dio;

  TicketsRemoteDataSourceImpl(this.dio);

  @override
  Future<TicketModel> createTicket({
    required String category,
    required String userNote,
  }) async {
    final response = await dio.post(
      '/v1/support/ticket',
      data: {'category': category, 'user_note': userNote},
    );

    return TicketModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<TicketListResponseModel> getTickets(TicketFilter filter) async {
    final response = await dio.get(
      '/v1/support/tickets', // Adjusted to match generic ticket list endpoint if applicable
      queryParameters: filter.toQuery(),
    );

    return TicketListResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
