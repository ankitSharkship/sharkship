import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sharkship/core/providers/app_providers.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:sharkship/core/services/shared_preferences_service.dart';
// import 'package:sharkship/features/kyc/presentation/servieces/digilocker_deep_link_service.dart';
import 'app.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // DigilockerDeepLinkService().init();
  await dotenv.load(fileName: ".env.dev");
  // await dotenv.load(fileName: ".env.prod");
  await Hive.initFlutter();
  await Hive.openBox('user_box');
  await SharedPreferencesService.init();
  final config = PostHogConfig(dotenv.env['POSTHOG_KEY'] ?? "");
  config.host = 'https://us.i.posthog.com';
  config.captureApplicationLifecycleEvents = true;
  config.debug = false;
  config.sessionReplay = true;
  config.sessionReplayConfig.maskAllTexts = false;
  config.sessionReplayConfig.maskAllImages = false;
  config.sessionReplayConfig.throttleDelay = const Duration(milliseconds: 1000);
  await Posthog().setup(config);
  // await PhonePePaymentSdk.init("sandbox", "", "", true);
  runApp(const ProviderScope(child: AppBootstrap()));
}

class AppBootstrap extends ConsumerWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final key = ref.watch(appContainerKeyProvider);

    return ProviderScope(key: key, child: const MyApp());
  }
}


// stanford cs229 cs224n nlp. cs336 language modelling

