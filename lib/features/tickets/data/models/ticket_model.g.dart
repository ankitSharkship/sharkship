// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
  id: (json['id'] as num).toInt(),
  qDate: json['query_date'] == null
      ? null
      : DateTime.parse(json['query_date'] as String),
  rDate: json['resolved_date'] == null
      ? null
      : DateTime.parse(json['resolved_date'] as String),
  ticketCategory: json['category'] as String,
  ticketStatus: json['status'] as String? ?? 'PENDING',
  note: json['user_note'] as String? ?? '',
  aNote: json['admin_note'] as String?,
  message: json['message'] as String?,
  userModel: json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'query_date': instance.qDate?.toIso8601String(),
      'resolved_date': instance.rDate?.toIso8601String(),
      'category': instance.ticketCategory,
      'status': instance.ticketStatus,
      'user_note': instance.note,
      'admin_note': instance.aNote,
      'message': instance.message,
      'user': instance.userModel?.toJson(),
    };

TicketListResponseModel _$TicketListResponseModelFromJson(
  Map<String, dynamic> json,
) => TicketListResponseModel(
  totalTickets: (json['totalTickets'] as num).toInt(),
  tickets: (json['tickets'] as List<dynamic>)
      .map((e) => TicketModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TicketListResponseModelToJson(
  TicketListResponseModel instance,
) => <String, dynamic>{
  'totalTickets': instance.totalTickets,
  'tickets': instance.tickets.map((e) => e.toJson()).toList(),
};
