import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'courier_settings_state.dart';
import 'orders_provider.dart';

part 'courier_settings_notifier.g.dart';

@riverpod
class CourierSettingsNotifier extends _$CourierSettingsNotifier {
  @override
  FutureOr<CourierSettingsState> build() async {
    return _fetchSettings();
  }
  
  Future<CourierSettingsState> _fetchSettings() async {
    final getPriority = ref.read(getCourierPriorityUseCaseProvider);
    final getPartners = ref.read(getCourierPartnersUseCaseProvider);
    final getAddresses = ref.read(getPickupAddressesUseCaseProvider);

    try {
      final results = await Future.wait([
        getPriority.execute(),
        getPartners.execute(),
        getAddresses.execute(),
      ]);

      return CourierSettingsState(
        priority: results[0] as dynamic,
        partners: results[1] as dynamic,
        addresses: results[2] as dynamic,
        isLoading: false,
      );
    } catch (e) {
      return CourierSettingsState(error: e.toString(), isLoading: false);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchSettings());
  }

  Future<bool> updatePriority(Map<String, dynamic> data) async {
    final useCase = ref.read(updateCourierPriorityUseCaseProvider);
    try {
      final success = await useCase.execute(data);
      if (success) {
        await refresh();
      }
      return success;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setDefaultAddress(int id) async {
    final useCase = ref.read(setDefaultPickupAddressUseCaseProvider);
    try {
      final success = await useCase.execute(id);
      if (success) {
        await refresh();
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}
