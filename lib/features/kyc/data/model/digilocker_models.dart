import '../../domain/entities/digilocker_init.dart';

class DigilockerInitModel extends DigilockerInitEntity {
  DigilockerInitModel({required super.url, required super.verificationId});

  factory DigilockerInitModel.fromJson(Map<String, dynamic> json) {
    return DigilockerInitModel(
      url: json['url'] as String,
      verificationId: json['verification_id'] as String,
    );
  }
}

class DigilockerStatusModel {
  final String status;
  final String? message;

  DigilockerStatusModel({required this.status, this.message});

  factory DigilockerStatusModel.fromJson(Map<String, dynamic> json) {
    return DigilockerStatusModel(
      status: json['status'] as String,
      message: json['message'] as String?,
    );
  }

  bool get isSuccess => status == 'SUCCESS';
}

