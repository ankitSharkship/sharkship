import '../../domain/entities/order_address_entity.dart';

class OrderAddressModel extends OrderAddressEntity {
  OrderAddressModel({
    super.id,
    super.addressLane1,
    super.addressLane2,
    super.landmark,
    super.city,
    super.state,
    super.pin,
    super.phoneNo,
    super.name,
  });

  factory OrderAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderAddressModel(
      id: json['id'] as int?,
      addressLane1: json['address_lane1']?.toString(),
      addressLane2: json['address_lane2']?.toString(),
      landmark: json['landmark']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      pin: json['Pin'] != null ? int.tryParse(json['Pin'].toString()) : null,
      phoneNo: json['phone_no']?.toString(),
      name: json['name']?.toString(),
    );
  }
}
