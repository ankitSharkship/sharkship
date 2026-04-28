import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:sharkship/core/providers/app_providers.dart';
import 'package:sharkship/features/tickets/data/datasources/tickets_remote_datasource.dart';
import 'package:sharkship/features/tickets/data/repositories/tickets_repository_impl.dart';
import 'package:sharkship/features/tickets/domain/repositories/tickets_repository.dart';
import 'package:sharkship/features/tickets/domain/usecases/create_ticket_usecase.dart';
import 'package:sharkship/features/tickets/domain/usecases/get_tickets_usecase.dart';
import 'package:sharkship/features/tickets/domain/entities/ticket.dart';

part 'tickets_providers.g.dart';

@riverpod
TicketsRemoteDataSource ticketsRemoteDataSource(Ref ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TicketsRemoteDataSourceImpl(dioClient.dio);
}

@riverpod
TicketsRepository ticketsRepository(Ref ref) {
  final dataSource = ref.watch(ticketsRemoteDataSourceProvider);
  return TicketsRepositoryImpl(dataSource);
}

@riverpod
CreateTicketUseCase createTicketUseCase(Ref ref) {
  final repository = ref.watch(ticketsRepositoryProvider);
  return CreateTicketUseCase(repository);
}

@riverpod
GetTicketsUseCase getTicketsUseCase(Ref ref) {
  final repository = ref.watch(ticketsRepositoryProvider);
  return GetTicketsUseCase(repository);
}

@riverpod
Future<TicketListResponse> ticketsList(Ref ref, TicketFilter filter) async {
  return await ref.watch(getTicketsUseCaseProvider).call(filter);
}
