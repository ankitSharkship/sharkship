import '../../domain/entities/whatsapp_config_entity.dart';

class WhatsappConfigModel extends WhatsappConfigEntity {
  const WhatsappConfigModel({
    required super.id,
    required super.shipped,
    required super.ndr,
    required super.outForDelivery,
    required super.returned,
    required super.delivered,
    required super.processed,
    required super.channel,
    required super.manual,
    required super.createdAt,
    required super.updatedAt,
  });

  factory WhatsappConfigModel.fromJson(Map<String, dynamic> json) {
    return WhatsappConfigModel(
      id: json['id'] ?? '',
      shipped: json['shipped'] ?? false,
      ndr: json['ndr'] ?? false,
      outForDelivery: json['out_for_delivery'] ?? false,
      returned: json['returned'] ?? false,
      delivered: json['delivered'] ?? false,
      processed: json['processed'] ?? false,
      channel: json['channel'] ?? false,
      manual: json['manual'] ?? false,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shipped': shipped,
      'ndr': ndr,
      'out_for_delivery': outForDelivery,
      'returned': returned,
      'delivered': delivered,
      'processed': processed,
      'channel': channel,
      'manual': manual,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
