import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/tickets/data/datasources/ticket_remote_datasource_impl.dart';
import 'package:sharkship/features/tickets/data/datasources/tikcet_remote_datasource.dart';
import 'package:sharkship/features/tickets/data/repository/ticket_repository_impl.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';
import 'package:sharkship/features/tickets/domain/repository/ticket_repository.dart';
import 'package:sharkship/features/tickets/domain/usecases/get_tickets_usecase.dart';

final ticketRemoteDataSourceProvider = Provider<TicketRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider).dio;
  return TicketRemoteDataSourceImpl(dio);
});

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  return TicketRepositoryImpl(ref.read(ticketRemoteDataSourceProvider));
});

final getTicketsProvider = Provider<GetTickets>((ref) {
  return GetTickets(ref.read(ticketRepositoryProvider));
});

final ticketsProvider = FutureProvider.family<TicketListResponse, TicketFilter>(
  (ref, filter) async {
    return ref.read(getTicketsProvider)(filter);
  },
);
