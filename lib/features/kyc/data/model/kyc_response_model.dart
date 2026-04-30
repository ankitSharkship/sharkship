import 'package:sharkship/features/user/data/models/user_model.dart';

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
  final String? dob;
  final String? address;
  final String? aadharProfileImage;
  final String? cancelledCheque;
  final String? panName;
  final DateTime? panIncorporationDate;
  final String? panType;
  final String? gstin;
  final bool? gstVerificationStatus;
  final String? gstAnnexureUrl;
  final int? gstAddressId;
  final String? gstLegalBusinessName;
  final String? gstTradeBusinessName;
  final DateTime? gstRegistrationDate;
  final String? constitutionOfBusiness;
  final String? udyamNumber;
  final String? enterpriseName;
  final String? organizationType;
  final String? majorActivity;
  final DateTime? dateOfIncorporation;
  final DateTime? dateOfCommencement;
  final DateTime? dateOfUdyamRegistration;
  final String? enterpriseType;
  final String? udyamCertificateUrl;
  final String? udyamAddress;
  final Map<String, dynamic>? gstAddress;
  final CinDetailsModel? cinDetails;
  final UserModel? userData;

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
    this.dob,
    this.address,
    this.aadharProfileImage,
    this.userData,
    this.cancelledCheque,
    this.panName,
    this.panIncorporationDate,
    this.panType,
    this.gstin,
    this.gstVerificationStatus,
    this.gstAnnexureUrl,
    this.gstAddressId,
    this.gstLegalBusinessName,
    this.gstTradeBusinessName,
    this.gstRegistrationDate,
    this.constitutionOfBusiness,
    this.udyamNumber,
    this.enterpriseName,
    this.organizationType,
    this.majorActivity,
    this.dateOfIncorporation,
    this.dateOfCommencement,
    this.dateOfUdyamRegistration,
    this.enterpriseType,
    this.udyamCertificateUrl,
    this.udyamAddress,
    this.gstAddress,
    this.cinDetails,
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
      gstNumber: json['gstin'] as String?, // Based on provided response structure
      aadharName: json['aadhar_name'] as String?,
      dob: json['dob'] as String?,
      address: json['address'] as String?,
      aadharProfileImage: json['aadhar_profile_image'] as String?,
      cancelledCheque: json['cancelled_cheque'] as String?,
      panName: json['pan_name'] as String?,
      panIncorporationDate: json['pan_incorporation_date'] != null
          ? DateTime.tryParse(json['pan_incorporation_date'])
          : null,
      panType: json['pan_type'] as String?,
      gstin: json['gstin'] as String?,
      gstVerificationStatus: json['gst_verification_status'] as bool?,
      gstAnnexureUrl: json['gst_annexure_url'] as String?,
      gstAddressId: json['gstAddressId'] as int?,
      gstLegalBusinessName: json['gst_legal_business_name'] as String?,
      gstTradeBusinessName: json['gst_trade_business_name'] as String?,
      gstRegistrationDate: json['gst_registration_date'] != null
          ? DateTime.tryParse(json['gst_registration_date'])
          : null,
      constitutionOfBusiness: json['constitution_of_business'] as String?,
      udyamNumber: json['udyam_number'] as String?,
      enterpriseName: json['enterprise_name'] as String?,
      organizationType: json['organization_type'] as String?,
      majorActivity: json['major_activity'] as String?,
      dateOfIncorporation: json['date_of_incorporation'] != null
          ? DateTime.tryParse(json['date_of_incorporation'])
          : null,
      dateOfCommencement: json['date_of_commencement'] != null
          ? DateTime.tryParse(json['date_of_commencement'])
          : null,
      dateOfUdyamRegistration: json['date_of_udyam_registration'] != null
          ? DateTime.tryParse(json['date_of_udyam_registration'])
          : null,
      enterpriseType: json['enterprise_type'] as String?,
      udyamCertificateUrl: json['udyam_certificate_url'] as String?,
      udyamAddress: json['udyam_address'] as String?,
      gstAddress: json['gstAddress'] as Map<String, dynamic>?,
      cinDetails: json['cinDetails'] != null
          ? CinDetailsModel.fromJson(json['cinDetails'])
          : null,
      userData: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  bool get isAadhaarComplete =>
      (aadharFrontUrl != null && aadharFrontUrl!.isNotEmpty) ||
      (aadharNumber != null && aadharNumber!.isNotEmpty) ||
      (aadharName != null && aadharName!.isNotEmpty);

  bool get isPanComplete => pan != null && pan!.isNotEmpty;

  bool get isBankComplete => accountNumber != null && accountNumber!.isNotEmpty;

  bool get isGstComplete => gstin != null && gstin!.isNotEmpty;
}

class CinDetailsModel {
  final String? cin;
  final String? companyName;
  final String? registrationNumber;
  final String? cinEmail;
  final DateTime? incorporationDate;
  final List<DirectorModel>? directors;

  CinDetailsModel({
    this.cin,
    this.companyName,
    this.registrationNumber,
    this.cinEmail,
    this.incorporationDate,
    this.directors,
  });

  factory CinDetailsModel.fromJson(Map<String, dynamic> json) {
    return CinDetailsModel(
      cin: json['cin'] as String?,
      companyName: json['company_name'] as String?,
      registrationNumber: json['registration_number'] as String?,
      cinEmail: json['cin_email'] as String?,
      incorporationDate: json['incorporation_date'] != null
          ? DateTime.tryParse(json['incorporation_date'])
          : null,
      directors: (json['directors'] as List?)
          ?.map((e) => DirectorModel.fromJson(e))
          .toList(),
    );
  }
}

class DirectorModel {
  final String? name;
  final String? din;
  final String? designation;
  final String? dob;

  DirectorModel({
    this.name,
    this.din,
    this.designation,
    this.dob,
  });

  factory DirectorModel.fromJson(Map<String, dynamic> json) {
    return DirectorModel(
      name: json['name'] as String?,
      din: json['din'] as String?,
      designation: json['designation'] as String?,
      dob: json['dob'] as String?,
    );
  }
}
