import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class VerifyGstUsecase {
  final KycRepository repo;
  VerifyGstUsecase(this.repo);
  Future<bool> call(String gstNumber, String gstImage) async {
    return await repo.verifyGst(gstNumber, gstImage);
  }
}
