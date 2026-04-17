import '../repositories/wd_repository.dart';

class UploadDisputeUseCase {
  final WdRepository repository;

  UploadDisputeUseCase(this.repository);

  Future<void> execute({
    required String trackingId,
    required List<String> filePaths,
  }) async {
    return await repository.uploadDispute(
      trackingId: trackingId,
      filePaths: filePaths,
    );
  }
}
