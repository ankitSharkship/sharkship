import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
// import 'package:sharkship/features/kyc/presentation/servieces/digilocker_deep_link_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DigilockerDeepLinkService().init();
  await Hive.initFlutter();
  await Hive.openBox('user_box');
  //   await PhonePePaymentSdk.init(
  //   environment: Environment.sandbox,
  //   merchantId: "YOUR_MERCHANT_ID",
  //   appId: "",
  //   enableLogging: true,
  // );
  await PhonePePaymentSdk.init("sandbox", "", "", true);
  runApp(const ProviderScope(child: MyApp()));
}
// 7847635647