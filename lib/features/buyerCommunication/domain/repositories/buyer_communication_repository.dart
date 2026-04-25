import 'package:dartz/dartz.dart';
import 'package:sharkship/core/errors/failures.dart';
import 'package:sharkship/features/buyerCommunication/domain/entities/sms_charge_entity.dart';
import 'package:sharkship/features/buyerCommunication/domain/entities/whatsapp_config_entity.dart';

abstract class BuyerCommunicationRepository {
  Future<Either<Failure, SmsChargeEntity>> getSmsCharge();
  Future<Either<Failure, WhatsappConfigEntity>> getWhatsappConfig();
  Future<Either<Failure, void>> updateWhatsappSmsConfig(
    Map<String, dynamic> data,
  );
  Future<void> toggleWhatsappConfig();
  Future<Either<Failure, void>> sendWhatsappDemo(String phoneNo);
}
