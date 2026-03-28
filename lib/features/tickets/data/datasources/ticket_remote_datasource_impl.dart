import 'package:dio/dio.dart';
import 'package:sharkship/features/tickets/data/datasources/tikcet_remote_datasource.dart';
import 'package:sharkship/features/tickets/data/model/ticket_model.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  final Dio dio;

  TicketRemoteDataSourceImpl(this.dio);

  @override
  Future<TicketListResponseModel> getTickets(TicketFilter filter) async {
    final response = await dio.get(
      '/v1/support/tickets',
      queryParameters: filter.toQuery(),
    );

    return TicketListResponseModel.fromJson(response.data);
  }
}
