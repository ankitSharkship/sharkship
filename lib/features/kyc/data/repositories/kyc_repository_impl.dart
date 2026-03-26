import 'package:sharkship/core/network/api_exception.dart';
import 'package:sharkship/features/kyc/data/datasources/kyc_remote_datasource.dart';
import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class KycRepositoryImpl implements KycRepository {
  final KycRemoteDataSource remote;

  KycRepositoryImpl(this.remote);

  @override
  Future<bool> verifyPan(String pan) async {
    await remote.verifyPan(pan);
    return true; // success = no exception
  }

  @override
  Future<bool> verifyBank(BankData bank) async {
    await remote.verifyBank(
      ifsc: bank.ifscCode,
      accountNumber: bank.accountNumber,
      accountType: bank.accountType,
      accountHolderName: bank.accountHolderName,
    );
    return true;
  }

  @override
  Future<bool> verifyGst(String gst, String gstImage) async {
    await remote.verifyGst(gst);
    return true;
  }

  @override
  Future<void> uploadAadhaar({
    required String front,
    required String back,
  }) async {
    final res = await remote.uploadAadhaar(frontPath: front, backPath: back);

    if (!res.isValid) {
      throw ApiException(message: res.message);
    }
  }

  @override
  Future<void> verifyAadhaar() async {}

  @override
  Future<void> submitKyc(Kyc kyc) async {
    // not defined in your API yet
  }
}
