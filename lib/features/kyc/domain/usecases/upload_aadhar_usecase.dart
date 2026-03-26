import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class UploadAadharUsecase {
  final KycRepository repo;
  UploadAadharUsecase(this.repo);

  Future<void> call(String front, String back) async {
    return await repo.uploadAadhaar(front: front, back: back);
  }
}
