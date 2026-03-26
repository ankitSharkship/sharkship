class Kyc {
  final AadhaarData? aadhaar;
  final PanData? pan;
  final BankData? bank;
  final GstData? gst;

  final bool isSubmitted;

  const Kyc({
    this.aadhaar,
    this.pan,
    this.bank,
    this.gst,
    this.isSubmitted = false,
  });

  Kyc copyWith({
    AadhaarData? aadhaar,
    PanData? pan,
    BankData? bank,
    GstData? gst,
    bool? isSubmitted,
  }) {
    return Kyc(
      aadhaar: aadhaar ?? this.aadhaar,
      pan: pan ?? this.pan,
      bank: bank ?? this.bank,
      gst: gst ?? this.gst,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  bool get isComplete => aadhaar != null && pan != null && bank != null;
}

class AadhaarData {
  final String? frontImage;
  final String? backImage;
  final bool isVerified;
  final bool isDigilocker;

  AadhaarData({
    this.frontImage,
    this.backImage,
    this.isVerified = false,
    this.isDigilocker = false,
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

  BankData({
    this.accountHolderName = "",
    this.accountNumber = "",
    this.ifscCode = "",
    this.accountType = "",
  });
}

class GstData {
  final String gstNumber;
  final String gstImage;
  final bool isVerified;

  GstData({this.gstNumber = "", this.gstImage = "", this.isVerified = false});
}
