class Kyc {
  final AadhaarData? aadhaar;
  final PanData? pan;
  final BankData? bank;
  final GstData? gst;

  final bool isSubmitted;
  final String status;
  final bool agreementAccepted;
  final String entityType;

  const Kyc({
    this.aadhaar,
    this.pan,
    this.bank,
    this.gst,
    this.isSubmitted = false,
    this.status = "INITIATED",
    this.agreementAccepted = false,
    this.entityType = "SOLE_PROPRIETORSHIP",
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

  AadhaarData({
    this.frontImage,
    this.backImage,
    this.aadharName,
    this.aadharNumber,
    this.aadharProfileImage,
    this.isVerified = false,
    this.isDigilocker = false,
    this.isRejected = false,
  });
}

class PanData {
  final String panNumber;
  final bool isVerified;

  PanData({this.panNumber = "", this.isVerified = false});
}

class BankData {
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String accountType;
  final bool isVerified;

  BankData({
    this.accountHolderName = "",
    this.accountNumber = "",
    this.ifscCode = "",
    this.accountType = "",
    this.isVerified = false,
  });
}

class GstData {
  final String gstNumber;
  final String gstImage;
  final bool isVerified;

  GstData({this.gstNumber = "", this.gstImage = "", this.isVerified = false});
}
