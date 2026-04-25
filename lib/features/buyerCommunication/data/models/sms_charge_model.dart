import '../../domain/entities/sms_charge_entity.dart';

class SmsChargeModel extends SmsChargeEntity {
  const SmsChargeModel({
    required super.manualCharge,
    required super.channelCharge,
    required super.statusCharge,
  });

  factory SmsChargeModel.fromJson(Map<String, dynamic> json) {
    return SmsChargeModel(
      manualCharge: json['manual_charge']?.toString() ?? '0.00',
      channelCharge: json['channel_charge']?.toString() ?? '0.00',
      statusCharge: json['status_charge']?.toString() ?? '0.00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manual_charge': manualCharge,
      'channel_charge': channelCharge,
      'status_charge': statusCharge,
    };
  }
}
