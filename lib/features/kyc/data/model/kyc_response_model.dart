class KycResponseModel {
  final int? id;
  final String? aadharNumber;
  final String? aadharFrontUrl;
  final String? aadharBackUrl;
  final String? pan;
  final bool? aadharVerified;
  final bool? panVerified;
  final String? kycStep;
  final String? bankName;
  final String? ifsc;
  final String? accountType;
  final String? accountNumber;
  final String? accountHolderName;
  final String? entityType;
  final String? status;
  final bool? agreementAccepted;
  final String? kycTicketStatus;
  final String? gstNumber;
  final String? aadharName;
  final String? aadharProfileImage;

  KycResponseModel({
    this.id,
    this.aadharNumber,
    this.aadharFrontUrl,
    this.aadharBackUrl,
    this.pan,
    this.aadharVerified,
    this.panVerified,
    this.kycStep,
    this.bankName,
    this.ifsc,
    this.accountType,
    this.accountNumber,
    this.accountHolderName,
    this.entityType,
    this.status,
    this.agreementAccepted,
    this.kycTicketStatus,
    this.gstNumber,
    this.aadharName,
    this.aadharProfileImage,
  });

  factory KycResponseModel.fromJson(Map<String, dynamic> json) {
    return KycResponseModel(
      id: json['id'] as int?,
      aadharNumber: json['aadhar_number'] as String?,
      aadharFrontUrl: json['aadhar_front_url'] as String?,
      aadharBackUrl: json['aadhar_back_url'] as String?,
      pan: json['pan'] as String?,
      aadharVerified: json['aadhar_verification_status'] == true,
      panVerified: json['pan_verification_status'] == true,
      kycStep: json['user']?['kycStep'] as String?,
      bankName: json['bank_name'] as String?,
      ifsc: json['ifsc'] as String?,
      accountType: json['account_type'] as String?,
      accountNumber: json['account_number'] as String?,
      accountHolderName: json['account_holder_name'] as String?,
      entityType: json['user']?['entity_type'] as String?,
      status: json['status'] as String?,
      agreementAccepted: json['user']?['agreement_accept'] as bool?,
      kycTicketStatus: json['user']?['kycTicketStatus'] as String?,
      gstNumber: json['gst_number'] as String?,
      aadharName: json['aadhar_name'] as String?,
      aadharProfileImage: json['aadhar_profile_image'] as String?,
    );
  }

  bool get isAadhaarComplete =>
      (aadharFrontUrl != null && aadharFrontUrl!.isNotEmpty) ||
      (aadharNumber != null && aadharNumber!.isNotEmpty) ||
      (aadharName != null && aadharName!.isNotEmpty);

  bool get isPanComplete => pan != null && pan!.isNotEmpty;

  bool get isBankComplete => accountNumber != null && accountNumber!.isNotEmpty;

  bool get isGstComplete => gstNumber != null && gstNumber!.isNotEmpty;
}
