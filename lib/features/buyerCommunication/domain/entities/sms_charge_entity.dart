import 'package:equatable/equatable.dart';

class SmsChargeEntity extends Equatable {
  final String manualCharge;
  final String channelCharge;
  final String statusCharge;

  const SmsChargeEntity({
    required this.manualCharge,
    required this.channelCharge,
    required this.statusCharge,
  });

  @override
  List<Object?> get props => [manualCharge, channelCharge, statusCharge];
}
