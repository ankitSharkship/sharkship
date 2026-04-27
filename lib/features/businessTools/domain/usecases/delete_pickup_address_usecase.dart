import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class DeletePickupAddressUseCase {
  final BusinessToolsRepository repository;

  DeletePickupAddressUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deletePickupAddress(id);
  }
}
