import '../../domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  CustomerModel({
    required super.id,
    required super.mobileNo,
    required super.name,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      mobileNo: json['mobile_no']?.toString() ?? '',
      name: json['name'] ?? '',
    );
  }
}
