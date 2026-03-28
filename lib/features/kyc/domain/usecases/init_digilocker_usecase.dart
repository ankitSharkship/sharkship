import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../entities/digilocker_init.dart';
import '../repositories/kyc_repository.dart';
import '../../presentation/state/kyc_provider.dart';

part 'init_digilocker_usecase.g.dart';

class InitDigilockerUseCase {
  final KycRepository _repository;

  InitDigilockerUseCase(this._repository);

  Future<DigilockerInitEntity> call() async {
    return await _repository.initDigilocker();
  }
}

@riverpod
InitDigilockerUseCase initDigilockerUseCase(Ref ref) {
  return InitDigilockerUseCase(ref.watch(kycRepositoryProvider));
}
