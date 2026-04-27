import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/businessTools/data/datasources/business_tools_remote_datasource.dart';
import 'package:sharkship/features/businessTools/domain/entities/pickup_address_entity.dart';
import 'package:sharkship/features/businessTools/domain/entities/pin_details_entity.dart';
import 'package:sharkship/features/businessTools/domain/entities/retail_api_details_entity.dart';
import 'package:sharkship/features/businessTools/domain/repositories/business_tools_repository.dart';

class BusinessToolsRepositoryImpl implements BusinessToolsRepository {
  final BusinessToolsRemoteDataSource remoteDataSource;

  BusinessToolsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, PickupAddressEntity>> addPickupAddress(
    Map<String, dynamic> data,
  ) async {
    try {
      final result = await remoteDataSource.addPickupAddress(data);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePickupAddress(
    int id,
    Map<String, dynamic> data,
  ) async {
    try {
      await remoteDataSource.updatePickupAddress(id, data);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePickupAddress(int id) async {
    try {
      await remoteDataSource.deletePickupAddress(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PinDetailsEntity>> getPinDetails(String pinCode) async {
    try {
      final result = await remoteDataSource.getPinDetails(pinCode);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RetailApiDetailsEntity>> getRetailApiDetails() async {
    try {
      final result = await remoteDataSource.getRetailApiDetails();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestMisReport({
    required String startDate,
    required String endDate,
    required List<String> statuses,
    required List<String> carriers,
  }) async {
    try {
      await remoteDataSource.requestMisReport(
        startDate: startDate,
        endDate: endDate,
        statuses: statuses,
        carriers: carriers,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
