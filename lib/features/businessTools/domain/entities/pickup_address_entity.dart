import 'package:equatable/equatable.dart';
import 'package:sharkship/features/user/domain/entities/user.dart';

class PickupAddressEntity extends Equatable {
  final int? id;
  final String addressLane1;
  final String addressLane2;
  final String landmark;
  final String pin;
  final String city;
  final String state;
  final String name;
  final String phoneNo;
  final String? delhiverySurfaceAddressId;
  final String? delhiveryExpressAddressId;
  final String? delhiveryIntegration2kgAddressId;
  final String? delhiveryIntegration5kgAddressId;
  final String? delhiveryIntegration10kgAddressId;
  final String? delhiveryIntegration20kgAddressId;
  final String? blueDartSurfaceAddressId;
  final String? blueDartExpressAddressId;
  final String? shadowfaxSurfaceAddressId;
  final String? dtdcSurfaceAddressId;
  final String? dtdcExpressAddressId;
  final String? expressflyAddressId;
  final String? shiprocketAddressId;
  final String? blitzAddressId;
  final String? isDefault;
  final String? hidden;
  final User? user;

  const PickupAddressEntity({
    this.id,
    required this.addressLane1,
    required this.addressLane2,
    required this.landmark,
    required this.pin,
    required this.city,
    required this.state,
    required this.name,
    required this.phoneNo,
    this.delhiverySurfaceAddressId,
    this.delhiveryExpressAddressId,
    this.delhiveryIntegration2kgAddressId,
    this.delhiveryIntegration5kgAddressId,
    this.delhiveryIntegration10kgAddressId,
    this.delhiveryIntegration20kgAddressId,
    this.blueDartSurfaceAddressId,
    this.blueDartExpressAddressId,
    this.shadowfaxSurfaceAddressId,
    this.dtdcSurfaceAddressId,
    this.dtdcExpressAddressId,
    this.expressflyAddressId,
    this.shiprocketAddressId,
    this.blitzAddressId,
    this.isDefault,
    this.hidden,
    this.user,
  });

  @override
  List<Object?> get props => [
        id,
        addressLane1,
        addressLane2,
        landmark,
        pin,
        city,
        state,
        name,
        phoneNo,
        isDefault,
        hidden,
      ];
}
