import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/core/network/dio_exception_handler.dart';

import 'package:sharkship/features/user/presentation/state/user_providers.dart';
import '../../domain/entities/sms_charge_entity.dart';
import '../../domain/entities/whatsapp_config_entity.dart';
import 'buyer_communication_providers.dart';

part 'buyer_communication_notifier.g.dart';

class BuyerCommunicationData {
  final SmsChargeEntity? smsCharge;
  final WhatsappConfigEntity? whatsappConfig;
  final bool enabled;

  BuyerCommunicationData({
    this.enabled = false,
    this.smsCharge,
    this.whatsappConfig,
  });

  BuyerCommunicationData copyWith({
    SmsChargeEntity? smsCharge,
    WhatsappConfigEntity? whatsappConfig,
    bool? enabled,
  }) {
    return BuyerCommunicationData(
      smsCharge: smsCharge ?? this.smsCharge,
      whatsappConfig: whatsappConfig ?? this.whatsappConfig,
      enabled: enabled ?? this.enabled,
    );
  }
}

@riverpod
class BuyerCommunicationNotifier extends _$BuyerCommunicationNotifier {
  @override
  Future<BuyerCommunicationData> build() async {
    return _fetchData();
  }

  Future<BuyerCommunicationData> _fetchData() async {
    final result = await ref.read(getUserDetailsUseCaseProvider).call();
    final smsChargeEither = await ref.read(getSmsChargeUseCaseProvider).call();
    final configEither = await ref
        .read(getWhatsappConfigUseCaseProvider)
        .call();

    SmsChargeEntity? smsCharge;
    WhatsappConfigEntity? whatsappConfig;

    smsChargeEither.fold((l) => throw l.message, (r) => smsCharge = r);
    configEither.fold((l) => throw l.message, (r) => whatsappConfig = r);

    return BuyerCommunicationData(
      enabled: result.isWhatsappSms ?? false,
      smsCharge: smsCharge,
      whatsappConfig: whatsappConfig,
    );
  }


  Future<void> fetchConfigAndCharges() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchData());
  }

  Future<void> toggleWhatsappSmsConfig() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(toggleWhatsappSmsUsecaseProvider).execute();
      state = await AsyncValue.guard(() => _fetchData());
    } catch (e, st) {
      state = AsyncValue.error(DioExceptionHandler.handle(e), st);
    }
  }

  Future<bool> updateWhatsappSmsConfig(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();

    final result = await ref
        .read(updateWhatsappSmsConfigUseCaseProvider)
        .call(data);

    return result.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.current);
        return false;
      },
      (r) async {
        state = await AsyncValue.guard(() => _fetchData());
        return true;
      },
    );
  }

  Future<bool> sendWhatsappDemo(String phoneNo) async {
    final result = await ref.read(sendWhatsappDemoUseCaseProvider).call(phoneNo);
    return result.fold(
      (l) => throw l.message,
      (r) => true,
    );
  }
}


@riverpod
class MonthlyVolumeNotifier extends _$MonthlyVolumeNotifier {
  @override
  int build() {
    return 0;
  }

  void updateVolume(int newVolume) {
    state = newVolume;
  }
}

@riverpod
double estimatedMonthlyCost(Ref ref) {
  final volume = ref.watch(monthlyVolumeProvider);
  final smsCharge = ref
      .watch(buyerCommunicationProvider)
      .asData
      ?.value
      .smsCharge;
  if (smsCharge?.manualCharge == null) return 0.0;
  final costPerMessage = double.parse(smsCharge!.manualCharge);
  return volume * costPerMessage;
}
