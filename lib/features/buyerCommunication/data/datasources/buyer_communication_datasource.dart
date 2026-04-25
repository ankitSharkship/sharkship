import 'package:dio/dio.dart';
import 'package:sharkship/core/network/dio_client.dart';
import 'package:sharkship/features/buyerCommunication/data/models/sms_charge_model.dart';
import 'package:sharkship/features/buyerCommunication/data/models/whatsapp_config_model.dart';

class BuyerCommunicationDataSource {
  final Dio _dio;

  BuyerCommunicationDataSource(this._dio);

  Future<SmsChargeModel> getSmsCharge() async {
    final response = await _dio.get('/v1/user/sms_charge');
    return SmsChargeModel.fromJson(response.data);
  }

  Future<WhatsappConfigModel> getWhatsappConfig() async {
    final response = await _dio.get('/v1/user/whatsapp-config');
    return WhatsappConfigModel.fromJson(response.data);
  }

  Future<void> updateWhatsappSmsConfig(Map<String, dynamic> data) async {
    await _dio.put('/v1/user/whatsapp-config', data: data);
  }

  Future<void> toggleWhatsappConfig() async {
    await _dio.put('/v1/user/whatsapp-sms-update');
  }

  Future<void> sendWhatsappDemo(String phoneNo) async {
    await _dio.post('/v1/user/whatsapp-demo', data: {"phone_no": phoneNo});
  }
}
