import 'package:sharkship/features/kyc/domain/entities/kyc.dart';

abstract class KycRepository {
  Future<bool> verifyPan(String pan);
  Future<bool> verifyBank(BankData bank);
  Future<bool> verifyGst(String gstNumber, String gstImage);

  Future<void> uploadAadhaar({required String front, required String back});
  Future<void> verifyAadhaar();

  Future<void> submitKyc(Kyc kyc);
}
