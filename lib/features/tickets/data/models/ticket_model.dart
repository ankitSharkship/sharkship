import 'package:sharkship/features/tickets/domain/entities/ticket.dart';
import 'package:sharkship/features/user/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TicketModel extends Ticket {
  @JsonKey(name: 'id')
  final int id;
  
  @JsonKey(name: 'query_date')
  final DateTime? qDate;
  
  @JsonKey(name: 'resolved_date')
  final DateTime? rDate;
  
  @JsonKey(name: 'category')
  final String ticketCategory;
  
  @JsonKey(name: 'status', defaultValue: 'PENDING')
  final String ticketStatus;
  
  @JsonKey(name: 'user_note', defaultValue: '')
  final String note;
  
  @JsonKey(name: 'admin_note')
  final String? aNote;
  
  final String? message;

  @JsonKey(name: 'user')
  final UserModel? userModel;

   TicketModel({
    required this.id,
    this.qDate,
    this.rDate,
    required this.ticketCategory,
    required this.ticketStatus,
    required this.note,
    this.aNote,
    this.message,
    this.userModel,
  }) : super(
          id: id,
          queryDate: qDate ??  DateTime.now() , // Default for missing qDate (creation response)
          resolvedDate: rDate,
          category: ticketCategory,
          status: ticketStatus,
          userNote: note,
          adminNote: aNote,
          message: message,
          user: userModel,
        );

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> mutableJson = Map.from(json);

    // Creation response uses 'ticketId', listing uses 'id'
    if (mutableJson['id'] == null && mutableJson['ticketId'] != null) {
      mutableJson['id'] = mutableJson['ticketId'];
    }

    // Creation response uses 'note', listing uses 'user_note'
    if (mutableJson['user_note'] == null && mutableJson['note'] != null) {
      mutableJson['user_note'] = mutableJson['note'];
    }
    // Final fallback so generated cast never sees null
    mutableJson['user_note'] ??= '';

    // Creation response has no 'category' — default to empty string
    mutableJson['category'] ??= '';

    return _$TicketModelFromJson(mutableJson);
  }

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TicketListResponseModel {
  final int totalTickets;
  final List<TicketModel> tickets;

  const TicketListResponseModel({
    required this.totalTickets,
    required this.tickets,
  });

  factory TicketListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TicketListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketListResponseModelToJson(this);

  TicketListResponse toEntity() => TicketListResponse(
        totalTickets: totalTickets,
        tickets: tickets,
      );
}
