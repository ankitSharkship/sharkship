import 'package:sharkship/features/businessTools/domain/entities/retail_api_details_entity.dart';

class RetailApiDetailsModel extends RetailApiDetailsEntity {
  RetailApiDetailsModel({
    required super.apiSecret,
    required super.apiKey,
    required super.status,
  });

  factory RetailApiDetailsModel.fromJson(Map<String, dynamic> json) {
    return RetailApiDetailsModel(
      apiSecret: json['api_secret'] as String? ?? '',
      apiKey: json['api_key'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'api_secret': apiSecret,
      'api_key': apiKey,
      'status': status,
    };
  }
}
