import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/entities/pin_details_entity.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class GetPinDetailsUseCase {
  final BusinessToolsRepository repository;

  GetPinDetailsUseCase(this.repository);

  Future<Either<Failure, PinDetailsEntity>> call(String pinCode) async {
    return await repository.getPinDetails(pinCode);
  }
}
