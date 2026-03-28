import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/kyc_repository.dart';
import '../../presentation/state/kyc_provider.dart';
import '../../data/model/digilocker_models.dart';

part 'get_digilocker_status_usecase.g.dart';

class GetDigilockerStatusUseCase {
  final KycRepository _repository;

  GetDigilockerStatusUseCase(this._repository);

  Future<DigilockerStatusModel> call(String verificationId) async {
    return await _repository.getDigilockerStatus(verificationId);
  }
}

@riverpod
GetDigilockerStatusUseCase getDigilockerStatusUseCase(Ref ref) {
  return GetDigilockerStatusUseCase(ref.watch(kycRepositoryProvider));
}
