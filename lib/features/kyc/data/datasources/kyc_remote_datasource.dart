import 'package:sharkship/features/kyc/data/model/aadhaar_response_model.dart';
import 'package:sharkship/features/kyc/data/model/digilocker_models.dart';
import 'package:sharkship/features/kyc/data/model/kyc_response_model.dart';

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

  Future<void> acceptKycDocuments();

  Future<KycResponseModel> fetchKycDetails();

  Future<DigilockerInitModel> initDigilocker();
  Future<DigilockerStatusModel> getDigilockerStatus(String verificationId);
  Future<void> submitKyc();
}
