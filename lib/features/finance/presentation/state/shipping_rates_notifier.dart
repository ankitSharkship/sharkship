import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/finance/presentation/state/sc_tab_provider.dart';
import '../../domain/entities/shipping_rate_entity.dart';
import 'finance_providers.dart';

part 'shipping_rates_notifier.g.dart';

@riverpod
class ShippingRatesNotifier extends _$ShippingRatesNotifier {
  @override
  FutureOr<List<ShippingRateEntity>> build() {
    final tab = ref.watch(scTabProvider);
    final serviceType = tab == 0 ? 'PAN_INDIA' : 'SDD_NDD';
    return getShippingRates(serviceType);
  }

  Future<List<ShippingRateEntity>> getShippingRates(String serviceType) async {
    state = const AsyncValue.loading();
    try {
      final rates = await ref
          .read(getShippingRatesUseCaseProvider)
          .execute(serviceType: serviceType);
      state = AsyncValue.data(rates);
      return rates;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
