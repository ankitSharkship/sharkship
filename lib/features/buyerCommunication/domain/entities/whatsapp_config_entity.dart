import 'package:equatable/equatable.dart';

class WhatsappConfigEntity extends Equatable {
  final String id;
  final bool shipped;
  final bool ndr;
  final bool outForDelivery;
  final bool returned;
  final bool delivered;
  final bool processed;
  final bool channel;
  final bool manual;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WhatsappConfigEntity({
    required this.id,
    required this.shipped,
    required this.ndr,
    required this.outForDelivery,
    required this.returned,
    required this.delivered,
    required this.processed,
    required this.channel,
    required this.manual,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        shipped,
        ndr,
        outForDelivery,
        returned,
        delivered,
        processed,
        channel,
        manual,
        createdAt,
        updatedAt,
      ];
}
