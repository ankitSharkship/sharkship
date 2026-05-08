// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WalletNotifier)
const walletProvider = WalletNotifierProvider._();

final class WalletNotifierProvider
    extends $NotifierProvider<WalletNotifier, WalletState> {
  const WalletNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletNotifierHash();

  @$internal
  @override
  WalletNotifier create() => WalletNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WalletState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WalletState>(value),
    );
  }
}

String _$walletNotifierHash() => r'5465d7bf58102374b27e3840f4c0e44d1e5d1654';

abstract class _$WalletNotifier extends $Notifier<WalletState> {
  WalletState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WalletState, WalletState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<WalletState, WalletState>,
              WalletState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
