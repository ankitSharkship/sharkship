import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class UpdatePickupAddressUseCase {
  final BusinessToolsRepository repository;

  UpdatePickupAddressUseCase(this.repository);

  Future<Either<Failure, void>> call(int id, Map<String, dynamic> data) async {
    return await repository.updatePickupAddress(id, data);
  }
}
