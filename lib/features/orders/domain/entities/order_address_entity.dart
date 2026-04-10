class OrderAddressEntity {
  final int? id;
  final String? addressLane1;
  final String? addressLane2;
  final String? landmark;
  final String? city;
  final String? state;
  final int? pin;
  final String? phoneNo;
  final String? name;
  final bool isDefault;

  OrderAddressEntity({
    this.id,
    this.addressLane1,
    this.addressLane2,
    this.landmark,
    this.city,
    this.state,
    this.pin,
    this.phoneNo,
    this.name,
    this.isDefault = false,
  });
}
