import 'package:equatable/equatable.dart';
import 'package:sharkship/features/user/domain/entities/user.dart';

class Ticket extends Equatable {
  final int id;
  final DateTime queryDate;
  final DateTime? resolvedDate;
  final String category;
  final String status;
  final String userNote;
  final String? adminNote;
  final String? message;
  final User? user;

  const Ticket({
    required this.id,
    required this.queryDate,
    this.resolvedDate,
    required this.category,
    required this.status,
    required this.userNote,
    this.adminNote,
    this.message,
    this.user,
  });

  @override
  List<Object?> get props => [
        id,
        queryDate,
        resolvedDate,
        category,
        status,
        userNote,
        adminNote,
        message,
        user,
      ];
}

class TicketFilter extends Equatable {
  final int total;
  final int skip;
  final String? status;
  final String category;
  final DateTime? startDate;
  final DateTime? endDate;

  const TicketFilter({
    required this.total,
    required this.skip,
    this.status,
    required this.category,
    this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toQuery() {
    return {
      "total": total,
      "skip": skip,
      if (status != null && status != "All") "status": status,
      if (category.isNotEmpty) "category": category,
      if (startDate != null) "startDate": startDate!.toIso8601String(),
      if (endDate != null) "endDate": endDate!.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [total, skip, status, category, startDate, endDate];
}

class TicketListResponse extends Equatable {
  final int totalTickets;
  final List<Ticket> tickets;

  const TicketListResponse({
    required this.totalTickets,
    required this.tickets,
  });

  @override
  List<Object?> get props => [totalTickets, tickets];
}
