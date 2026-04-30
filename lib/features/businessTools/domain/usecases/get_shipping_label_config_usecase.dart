import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/entities/shipping_label_config_entity.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class GetShippingLabelConfigUseCase {
  final BusinessToolsRepository repository;

  GetShippingLabelConfigUseCase(this.repository);

  Future<Either<Failure, ShippingLabelConfigEntity>> call() async {
    return repository.getShippingLabelConfig();
  }
}
