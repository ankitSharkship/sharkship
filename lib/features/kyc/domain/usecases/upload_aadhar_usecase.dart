import 'package:sharkship/features/kyc/data/model/aadhaar_response_model.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class UploadAadharUsecase {
  final KycRepository repo;
  UploadAadharUsecase(this.repo);

  Future<AadhaarResponseModel> call(String front, String back) async {
    return await repo.uploadAadhaar(front: front, back: back);
  }
}
