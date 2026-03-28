// lib/features/tickets/domain/entities/ticket_entity.dart
import 'package:sharkship/features/user/domain/entities/user.dart';

class Ticket {
  final int id;
  final DateTime queryDate;
  final DateTime? resolvedDate;
  final String category;
  final String status;
  final String userNote;
  final String? adminNote;
  final User user;

  Ticket({
    required this.id,
    required this.queryDate,
    this.resolvedDate, // Made optional since it's nullable
    required this.category,
    required this.status,
    required this.userNote,
    this.adminNote, // Made optional since it's nullable
    required this.user,
  });
}

class TicketFilter {
  final int total;
  final int skip;
  final String? status;
  final String category;

  TicketFilter({
    required this.total,
    required this.skip,
    this.status,
    required this.category,
  });

  Map<String, dynamic> toQuery() {
    return {
      "total": total,
      "skip": skip,
      if (status != null) "status": status,
      "category": category,
    };
  }
}


class TicketListResponse {
  final int totalTickets;
  final List<Ticket> tickets;

  TicketListResponse({
    required this.totalTickets,
    required this.tickets,
  });
}