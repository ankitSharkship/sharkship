import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/domain/entities/pickup_address_entity.dart';
import 'package:sharkship/features/businessTools/domain/entities/pin_details_entity.dart';
import 'package:sharkship/features/businessTools/domain/entities/retail_api_details_entity.dart';

abstract class BusinessToolsRepository {
  Future<Either<Failure, PickupAddressEntity>> addPickupAddress(
    Map<String, dynamic> data,
  );
  Future<Either<Failure, void>> updatePickupAddress(
    int id,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, void>> deletePickupAddress(int id);
  Future<Either<Failure, PinDetailsEntity>> getPinDetails(String pinCode);
  Future<Either<Failure, RetailApiDetailsEntity>> getRetailApiDetails();
  Future<Either<Failure, void>> requestMisReport({
    required String startDate,
    required String endDate,
    required List<String> statuses,
    required List<String> carriers,
  });
}
