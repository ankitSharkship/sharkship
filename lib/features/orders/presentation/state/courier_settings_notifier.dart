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

    try {
      final results = await Future.wait([
        getPriority.execute(),
        getPartners.execute(),
      ]);

      return CourierSettingsState(
        priority: results[0] as dynamic,
        partners: results[1] as dynamic,
        isLoading: false,
      );
    } catch (e) {
      return CourierSettingsState(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchSettings());
  }
}
