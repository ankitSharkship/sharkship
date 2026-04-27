import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/entities/pickup_address_entity.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class AddPickupAddressUseCase {
  final BusinessToolsRepository repository;

  AddPickupAddressUseCase(this.repository);

  Future<Either<Failure, PickupAddressEntity>> call(
    Map<String, dynamic> data,
  ) async {
    return await repository.addPickupAddress(data);
  }
}
