import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/entities/retail_api_details_entity.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class GetRetailApiDetailsUseCase {
  final BusinessToolsRepository repository;

  GetRetailApiDetailsUseCase(this.repository);

  Future<Either<Failure, RetailApiDetailsEntity>> call() {
    return repository.getRetailApiDetails();
  }
}
