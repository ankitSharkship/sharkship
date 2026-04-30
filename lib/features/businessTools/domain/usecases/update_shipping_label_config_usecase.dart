import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/entities/shipping_label_config_entity.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class UpdateShippingLabelConfigUseCase {
  final BusinessToolsRepository repository;

  UpdateShippingLabelConfigUseCase(this.repository);

  Future<Either<Failure, void>> call(ShippingLabelConfigEntity config) async {
    return repository.updateShippingLabelConfig(config);
  }
}
