import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/kyc/domain/repositories/kyc_repository.dart';
import 'package:sharkship/features/kyc/presentation/state/kyc_provider.dart';

part 'get_terms_usecase.g.dart';

class GetTermsUsecase {
  final KycRepository repo;
  GetTermsUsecase(this.repo);

  Future<String?> call() async {
    return await repo.getTermsHtml();
  }
}

@riverpod
GetTermsUsecase getTermsUsecase(Ref ref) {
  return GetTermsUsecase(ref.watch(kycRepositoryProvider));
}
