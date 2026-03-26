import 'package:sharkship/features/kyc/domain/entities/kyc.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';

class VerifyBankUsecase {
  final KycRepository repo;
  VerifyBankUsecase(this.repo);

  Future<bool> call(BankData bank) async {
    return await repo.verifyBank(bank);
  }
}
