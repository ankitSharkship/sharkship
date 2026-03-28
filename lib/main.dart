import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sharkship/features/kyc/presentation/servieces/digilocker_deep_link_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DigilockerDeepLinkService().init();
  await Hive.initFlutter();
  await Hive.openBox('user_box');
  runApp(const ProviderScope(child: MyApp()));
}
// 7847635647