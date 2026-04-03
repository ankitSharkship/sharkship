import 'package:sharkship/features/kyc/data/model/kyc_response_model.dart';
import 'package:sharkship/features/kyc/data/model/digilocker_models.dart';
import 'package:sharkship/features/kyc/domain/entities/digilocker_init.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';

abstract class KycRepository {
  Future<bool> verifyPan(String pan);
  Future<bool> verifyBank(BankData bank);
  Future<bool> verifyGst(String gstNumber, String gstImage);

  Future<void> uploadAadhaar({required String front, required String back});
  Future<void> verifyAadhaar();

  Future<void> submitKyc(Kyc kyc);
  Future<void> acceptKycDocuments();

  Future<KycResponseModel> fetchKycDetails();

  Future<DigilockerInitEntity> initDigilocker();
  Future<DigilockerStatusModel> getDigilockerStatus(String verificationId);
  Future<String> getTermsHtml();
}
