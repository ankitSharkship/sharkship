// lib/features/tickets/data/models/ticket_model.dart
import 'package:sharkship/features/tickets/domain/entities/ticket_entity.dart';
import 'package:sharkship/features/user/data/models/user_model.dart';

class TicketModel extends Ticket {
  TicketModel({
    required super.id,
    required super.queryDate,
    super.resolvedDate,
    required super.category,
    required super.status,
    required super.userNote,
    super.adminNote,
    required UserModel super.user, // Pass UserModel to the Entity's User field
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as int,
      // Parse strings to DateTime immediately during construction
      queryDate: DateTime.parse(json['query_date']),
      resolvedDate: json['resolved_date'] != null
          ? DateTime.parse(json['resolved_date'])
          : null,
      category: json['category'] as String,
      status: json['status'] as String,
      userNote: json['user_note'] as String,
      adminNote: json['admin_note'] as String?, // Keep as nullable
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  // If you extend the Entity, toEntity() becomes a simple return
  Ticket toEntity() => this;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'query_date': queryDate.toIso8601String(),
      'resolved_date': resolvedDate?.toIso8601String(),
      'category': category,
      'status': status,
      'user_note': userNote,
      'admin_note': adminNote,
      'user': (user as UserModel).toJson(), // Assuming UserModel has toJson
    };
  }
}

class TicketListResponseModel {
  final int totalTickets;
  final List<TicketModel> tickets;

  TicketListResponseModel({required this.totalTickets, required this.tickets});

  factory TicketListResponseModel.fromJson(Map<String, dynamic> json) {
    return TicketListResponseModel(
      totalTickets: json['totalTickets'] ?? 0,
      tickets: (json['tickets'] as List)
          .map((e) => TicketModel.fromJson(e))
          .toList(),
    );
  }

  TicketListResponse toEntity() {
    return TicketListResponse(
      totalTickets: totalTickets,
      tickets: tickets.map((e) => e.toEntity()).toList(),
    );
  }
}
