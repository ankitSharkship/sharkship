import '../../domain/entities/payment_confirm_entity.dart';

class PaymentConfirmModel extends PaymentConfirmEntity {
  const PaymentConfirmModel({
    required super.success,
    required super.message,
    required super.status,
  });

  factory PaymentConfirmModel.fromJson(Map<String, dynamic> json) {
    return PaymentConfirmModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'status': status,
    };
  }
}
