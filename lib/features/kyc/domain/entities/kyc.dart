import 'package:sharkship/features/user/domain/entities/user.dart';

class Kyc {
  final AadhaarData? aadhaar;
  final PanData? pan;
  final BankData? bank;
  final GstData? gst;

  final bool isSubmitted;
  final String status;
  final bool agreementAccepted;
  final String entityType;
  final User? user;
  final UdyamData? udyam;
  final CinData? cin;

  const Kyc({
    this.aadhaar,
    this.pan,
    this.bank,
    this.gst,
    this.isSubmitted = false,
    this.status = "INITIATED",
    this.agreementAccepted = false,
    this.entityType = "SOLE_PROPRIETORSHIP",
    this.user,
    this.udyam,
    this.cin,
  });

   Kyc copyWith({
    AadhaarData? aadhaar,
    PanData? pan,
    BankData? bank,
    GstData? gst,
    bool? isSubmitted,
    String? status,
    bool? agreementAccepted,
    String? entityType,
    User? user,
    UdyamData? udyam,
    CinData? cin,
  }) {
    return Kyc(
      aadhaar: aadhaar ?? this.aadhaar,
      pan: pan ?? this.pan,
      bank: bank ?? this.bank,
      gst: gst ?? this.gst,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      status: status ?? this.status,
      agreementAccepted: agreementAccepted ?? this.agreementAccepted,
      entityType: entityType ?? this.entityType,
      user: user ?? this.user,
      udyam: udyam ?? this.udyam,
      cin: cin ?? this.cin,
    );
  }

  // Returns true only for entity types that require Aadhaar upload
  bool get requiresAadhaar => entityType == "SOLE_PROPRIETORSHIP";

  // Returns true for entity types where GST is mandatory
  bool get requiresGst => entityType != "SOLE_PROPRIETORSHIP";

  bool get isComplete => aadhaar != null && pan != null && bank != null;
}

class AadhaarData {
  final String? frontImage;
  final String? backImage;
  final String? aadharName;
  final String? aadharNumber;
  final String? aadharProfileImage;
  final bool isVerified;
  final bool isDigilocker;
  final bool? isRejected;
  final String? dob;
  final String? address;

  AadhaarData({
    this.frontImage,
    this.backImage,
    this.aadharName,
    this.aadharNumber,
    this.aadharProfileImage,
    this.isVerified = false,
    this.isDigilocker = false,
    this.isRejected = false,
    this.dob,
    this.address,
  });
}

class PanData {
  final String panNumber;
  final bool isVerified;
  final String? panName;
  final DateTime? panIncorporationDate;
  final String? panType;

  PanData({
    this.panNumber = "",
    this.isVerified = false,
    this.panName,
    this.panIncorporationDate,
    this.panType,
  });
}

class BankData {
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String accountType;
  final String bankName;
  final String? cancelledCheque;
  final bool isVerified;

  BankData({
    this.accountHolderName = "",
    this.accountNumber = "",
    this.ifscCode = "",
    this.accountType = "",
    this.bankName = "",
    this.cancelledCheque,
    this.isVerified = false,
  });
}

class GstData {
  final String gstNumber;
  final String gstImage;
  final bool isVerified;
  final String? gstAnnexureUrl;
  final String? gstLegalBusinessName;
  final String? gstTradeBusinessName;
  final DateTime? gstRegistrationDate;
  final String? constitutionOfBusiness;

  GstData({
    this.gstNumber = "",
    this.gstImage = "",
    this.isVerified = false,
    this.gstAnnexureUrl,
    this.gstLegalBusinessName,
    this.gstTradeBusinessName,
    this.gstRegistrationDate,
    this.constitutionOfBusiness,
  });
}

class UdyamData {
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

  UdyamData({
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
  });
}

class CinData {
  final String? cin;
  final String? companyName;
  final String? registrationNumber;
  final String? cinEmail;
  final DateTime? incorporationDate;
  final List<DirectorData>? directors;

  CinData({
    this.cin,
    this.companyName,
    this.registrationNumber,
    this.cinEmail,
    this.incorporationDate,
    this.directors,
  });
}

class DirectorData {
  final String? name;
  final String? din;
  final String? designation;
  final String? dob;

  DirectorData({
    this.name,
    this.din,
    this.designation,
    this.dob,
  });
}
