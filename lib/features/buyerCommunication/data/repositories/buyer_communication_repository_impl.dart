import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/sms_charge_entity.dart';
import '../../domain/entities/whatsapp_config_entity.dart';
import '../../domain/repositories/buyer_communication_repository.dart';
import '../datasources/buyer_communication_datasource.dart';

class BuyerCommunicationRepositoryImpl implements BuyerCommunicationRepository {
  final BuyerCommunicationDataSource dataSource;

  BuyerCommunicationRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, SmsChargeEntity>> getSmsCharge() async {
    final result = await dataSource.getSmsCharge();
    return Right(result);
  }

  @override
  Future<Either<Failure, WhatsappConfigEntity>> getWhatsappConfig() async {
    final result = await dataSource.getWhatsappConfig();
    return Right(result);
  }

  @override
  Future<Either<Failure, void>> updateWhatsappSmsConfig(
    Map<String, dynamic> data,
  ) async {
    await dataSource.updateWhatsappSmsConfig(data);
    return const Right(null);
  }

  @override
  Future<void> toggleWhatsappConfig() async {
    await dataSource.toggleWhatsappConfig();
  }

  @override
  Future<Either<Failure, void>> sendWhatsappDemo(String phoneNo) async {
    try {
      await dataSource.sendWhatsappDemo(phoneNo);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
