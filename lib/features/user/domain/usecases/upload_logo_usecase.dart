import '../repositories/user_repository.dart';

class UploadLogoUseCase {
  final UserRepository repository;

  UploadLogoUseCase(this.repository);

  Future<void> call(String filePath) {
    return repository.uploadLogo(filePath);
  }
}
