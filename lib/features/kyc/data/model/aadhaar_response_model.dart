class AadhaarResponseModel {
  final String frontUrl;
  final String backUrl;
  final bool isValid;
  final String status;
  final String message;

  AadhaarResponseModel({
    required this.frontUrl,
    required this.backUrl,
    required this.isValid,
    required this.status,
    required this.message,
  });

  factory AadhaarResponseModel.fromJson(Map<String, dynamic> json) {
    final details = json['Details'] ?? {};

    return AadhaarResponseModel(
      frontUrl: json['frontUrl'] ?? '',
      backUrl: json['backUrl'] ?? '',
      isValid: details['valid'] ?? false,
      status: details['status'] ?? '',
      message: details['message'] ?? '',
    );
  }
}