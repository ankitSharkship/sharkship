import '../repositories/user_repository.dart';

class UpdatePersonalInfoUseCase {
  final UserRepository repository;

  UpdatePersonalInfoUseCase(this.repository);

  Future<void> call({
    required String userId,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNo,
    required String businessName,
    required String typeOfBusiness,
    required String otp,
    required String verifyId,
  }) {
    return repository.updatePersonalInfo(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNo: phoneNo,
      businessName: businessName,
      typeOfBusiness: typeOfBusiness,
      otp: otp,
      verifyId: verifyId,
    );
  }
}
