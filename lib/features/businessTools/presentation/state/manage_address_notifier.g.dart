// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_address_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ManageAddressNotifier)
const manageAddressProvider = ManageAddressNotifierProvider._();

final class ManageAddressNotifierProvider
    extends $AsyncNotifierProvider<ManageAddressNotifier, ManageAddressState> {
  const ManageAddressNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'manageAddressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$manageAddressNotifierHash();

  @$internal
  @override
  ManageAddressNotifier create() => ManageAddressNotifier();
}

String _$manageAddressNotifierHash() =>
    r'9806a21a62211615f50f224c1d51bebdae417257';

abstract class _$ManageAddressNotifier
    extends $AsyncNotifier<ManageAddressState> {
  FutureOr<ManageAddressState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<ManageAddressState>, ManageAddressState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ManageAddressState>, ManageAddressState>,
              AsyncValue<ManageAddressState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
