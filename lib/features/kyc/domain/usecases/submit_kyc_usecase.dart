import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class SubmitKycUsecase {
  final KycRepository repo;
  SubmitKycUsecase(this.repo);

  Future<void> call(Kyc kyc) async {
    return await repo.submitKyc(kyc);
  }
}
