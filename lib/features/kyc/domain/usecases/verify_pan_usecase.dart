import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class VerifyPanUseCase {
  final KycRepository repo;

  VerifyPanUseCase(this.repo);

  Future<bool> call(String pan) async {
    if (pan.length != 10) return false;

    return await repo.verifyPan(pan);
  }
}