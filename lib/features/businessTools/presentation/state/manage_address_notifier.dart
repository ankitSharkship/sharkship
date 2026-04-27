import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharkship/features/orders/presentation/state/courier_settings_notifier.dart';
import 'package:sharkship/features/businessTools/domain/entities/pin_details_entity.dart';
import 'package:sharkship/features/orders/presentation/state/orders_provider.dart';
import 'business_tools_providers.dart';
import 'package:sharkship/features/orders/domain/entities/order_address_entity.dart';

part 'manage_address_notifier.g.dart';

class ManageAddressState {
  final List<OrderAddressEntity> addresses;
  final int? defaultAddressId;

  ManageAddressState({required this.addresses, this.defaultAddressId});

  ManageAddressState copyWith({
    List<OrderAddressEntity>? addresses,
    int? defaultAddressId,
  }) {
    return ManageAddressState(
      addresses: addresses ?? this.addresses,
      defaultAddressId: defaultAddressId ?? this.defaultAddressId,
    );
  }
}

@riverpod
class ManageAddressNotifier extends _$ManageAddressNotifier {
  @override
  FutureOr<ManageAddressState> build() async {
    // Directly execute the use case to fetch addresses
    final addresses = await ref
        .read(getPickupAddressesUseCaseProvider)
        .execute();

    int? defaultId;
    if (addresses.isNotEmpty) {
      // Find the address explicitly marked as default
      final defaultAddr = addresses.where((a) => a.isDefault).firstOrNull;
      // Fallback to the first address if none is marked default
      defaultId = defaultAddr?.id ?? addresses.first.id;
    }

    return ManageAddressState(
      addresses: addresses,
      defaultAddressId: defaultId,
    );
  }

  Future<void> addNewAddress(Map<String, dynamic> data) async {
    state = const AsyncLoading();
    final result = await ref.read(addPickupAddressUseCaseProvider).call(data);

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) {
        // Invalidate self to trigger building again and fetching fresh data
        ref.invalidateSelf();
        // Also refresh courier settings if they are used elsewhere
        ref.read(courierSettingsProvider.notifier).refresh();
      },
    );
  }

  Future<void> editAddress(int id, Map<String, dynamic> data) async {
    state = const AsyncLoading();
    final result = await ref
        .read(updatePickupAddressUseCaseProvider)
        .call(id, data);

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) {
        ref.invalidateSelf();
        ref.read(courierSettingsProvider.notifier).refresh();
      },
    );
  }

  Future<void> deleteAddress(int id) async {
    state = const AsyncLoading();
    final result = await ref.read(deletePickupAddressUseCaseProvider).call(id);

    result.fold(
      (l) => state = AsyncValue.error(l.message, StackTrace.current),
      (r) {
        ref.invalidateSelf();
        ref.read(courierSettingsProvider.notifier).refresh();
      },
    );
  }

  Future<PinDetailsEntity?> getPinDetails(String pinCode) async {
    final result = await ref.read(getPinDetailsUseCaseProvider).call(pinCode);
    return result.fold((l) => null, (r) => r);
  }
}
