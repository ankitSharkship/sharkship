import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePeDataSource {
  bool _initialized = false;

  Future<void> init({
    required String environment, // "SANDBOX" or "PRODUCTION"
    required String merchantId,
    required String flowId,
    bool enableLogs = true,
  }) async {
    if (_initialized) return;

    final result = await PhonePePaymentSdk.init(
      environment,
      merchantId,
      flowId,
      enableLogs,
    );

    if (!result) {
      throw Exception('PhonePe SDK init failed');
    }

    _initialized = true;
  }

  Future<Map<String, dynamic>?> startTransaction({
    required String request, // base64 payload from backend
    String appSchema = "", // required only for iOS
  }) async {
    final response = await PhonePePaymentSdk.startTransaction(
      request,
      appSchema,
    );

    return response?.cast<String, dynamic>();
  }
}