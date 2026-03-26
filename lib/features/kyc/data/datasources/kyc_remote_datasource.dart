import 'package:sharkship/features/kyc/data/model/aadhaar_response_model.dart';

abstract class KycRemoteDataSource {
  Future<void> verifyPan(String pan);
  Future<void> verifyBank({
    required String ifsc,
    required String accountNumber,
    required String accountType,
    required String accountHolderName,
  });

  Future<void> verifyGst(String gst);

  Future<AadhaarResponseModel> uploadAadhaar({
    required String frontPath,
    required String backPath,
  });
}