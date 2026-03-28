import 'package:sharkship/features/kyc/data/model/kyc_response_model.dart';
import '../repositories/kyc_repository.dart';

class GetKycDetailsUseCase {
  final KycRepository repo;
  GetKycDetailsUseCase(this.repo);

  Future<KycResponseModel> call() async {
    return await repo.fetchKycDetails();
  }
}
