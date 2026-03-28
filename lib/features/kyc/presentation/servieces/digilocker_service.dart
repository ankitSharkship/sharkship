// lib/services/digilocker_service.dart

import 'package:dio/dio.dart';

class DigilockerInitResponse {
  final String verificationId;
  final int referenceId;
  final String url;
  final String status;
  final String redirectUrl;

  DigilockerInitResponse({
    required this.verificationId,
    required this.referenceId,
    required this.url,
    required this.status,
    required this.redirectUrl,
  });

  factory DigilockerInitResponse.fromJson(Map<String, dynamic> json) {
    return DigilockerInitResponse(
      verificationId: json['verification_id'] as String,
      referenceId: json['reference_id'] as int,
      url: json['url'] as String,
      status: json['status'] as String,
      redirectUrl: json['redirect_url'] as String,
    );
  }
}

class DigilockerService {
  final Dio _dio;

  DigilockerService(this._dio);

  // Calls your existing endpoint — no backend changes needed
  Future<DigilockerInitResponse> initAadhaarKyc() async {
    final response = await _dio.post(
      '/v1/user/kyc/verify',
      data: {'step': 'aadharUrl'},
    );
    return DigilockerInitResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  // Call this after the WebView flow completes to get KYC result
  Future<Map<String, dynamic>> getKycStatus(String verificationId) async {
    final response = await _dio.get('/v1/user/kyc/status/$verificationId');
    return response.data as Map<String, dynamic>;
  }
}
