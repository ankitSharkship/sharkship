import 'package:json_annotation/json_annotation.dart';
import 'package:sharkship/features/businessTools/domain/entities/pickup_address_entity.dart';
import 'package:sharkship/features/user/data/models/user_model.dart';

part 'pickup_address_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PickupAddressModel extends PickupAddressEntity {
  @override
  @JsonKey(name: 'address_lane1')
  final String addressLane1;

  @override
  @JsonKey(name: 'address_lane2')
  final String addressLane2;

  @override
  @JsonKey(name: 'Pin')
  final String pin;

  @override
  @JsonKey(name: 'phone_no')
  final String phoneNo;

  @override
  @JsonKey(name: 'delhivery_surface_address_id')
  final String? delhiverySurfaceAddressId;

  @override
  @JsonKey(name: 'delhivery_express_address_id')
  final String? delhiveryExpressAddressId;

  @override
  @JsonKey(name: 'delhivery_integration_2kg_address_id')
  final String? delhiveryIntegration2kgAddressId;

  @override
  @JsonKey(name: 'delhivery_integration_5kg_address_id')
  final String? delhiveryIntegration5kgAddressId;

  @override
  @JsonKey(name: 'delhivery_integration_10kg_address_id')
  final String? delhiveryIntegration10kgAddressId;

  @override
  @JsonKey(name: 'delhivery_integration_20kg_address_id')
  final String? delhiveryIntegration20kgAddressId;

  @override
  @JsonKey(name: 'blueDart_surface_address_id')
  final String? blueDartSurfaceAddressId;

  @override
  @JsonKey(name: 'blueDart_express_address_id')
  final String? blueDartExpressAddressId;

  @override
  @JsonKey(name: 'shadowfax_surface_address_id')
  final String? shadowfaxSurfaceAddressId;

  @override
  @JsonKey(name: 'dtdc_surface_address_id')
  final String? dtdcSurfaceAddressId;

  @override
  @JsonKey(name: 'dtdc_express_address_id')
  final String? dtdcExpressAddressId;

  @override
  @JsonKey(name: 'expressfly_address_id')
  final String? expressflyAddressId;

  @override
  @JsonKey(name: 'shiprocket_address_id')
  final String? shiprocketAddressId;

  @override
  @JsonKey(name: 'blitz_address_id')
  final String? blitzAddressId;

  @override
  @JsonKey(name: 'default')
  final String? isDefault;

  @override
  @JsonKey(name: 'user')
  final UserModel? user;

  const PickupAddressModel({
    super.id,
    required this.addressLane1,
    required this.addressLane2,
    required super.landmark,
    required this.pin,
    required super.city,
    required super.state,
    required super.name,
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
    super.hidden,
    this.user,
  }) : super(
          addressLane1: addressLane1,
          addressLane2: addressLane2,
          pin: pin,
          phoneNo: phoneNo,
          delhiverySurfaceAddressId: delhiverySurfaceAddressId,
          delhiveryExpressAddressId: delhiveryExpressAddressId,
          delhiveryIntegration2kgAddressId: delhiveryIntegration2kgAddressId,
          delhiveryIntegration5kgAddressId: delhiveryIntegration5kgAddressId,
          delhiveryIntegration10kgAddressId: delhiveryIntegration10kgAddressId,
          delhiveryIntegration20kgAddressId: delhiveryIntegration20kgAddressId,
          blueDartSurfaceAddressId: blueDartSurfaceAddressId,
          blueDartExpressAddressId: blueDartExpressAddressId,
          shadowfaxSurfaceAddressId: shadowfaxSurfaceAddressId,
          dtdcSurfaceAddressId: dtdcSurfaceAddressId,
          dtdcExpressAddressId: dtdcExpressAddressId,
          expressflyAddressId: expressflyAddressId,
          shiprocketAddressId: shiprocketAddressId,
          blitzAddressId: blitzAddressId,
          isDefault: isDefault,
          user: user,
        );

  factory PickupAddressModel.fromJson(Map<String, dynamic> json) =>
      _$PickupAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$PickupAddressModelToJson(this);
}
