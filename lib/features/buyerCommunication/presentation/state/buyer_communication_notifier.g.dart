// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer_communication_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BuyerCommunicationNotifier)
const buyerCommunicationProvider = BuyerCommunicationNotifierProvider._();

final class BuyerCommunicationNotifierProvider
    extends
        $AsyncNotifierProvider<
          BuyerCommunicationNotifier,
          BuyerCommunicationData
        > {
  const BuyerCommunicationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'buyerCommunicationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$buyerCommunicationNotifierHash();

  @$internal
  @override
  BuyerCommunicationNotifier create() => BuyerCommunicationNotifier();
}

String _$buyerCommunicationNotifierHash() =>
    r'cd73d6176d214b538659ee97487437b39c98c8d5';

abstract class _$BuyerCommunicationNotifier
    extends $AsyncNotifier<BuyerCommunicationData> {
  FutureOr<BuyerCommunicationData> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<BuyerCommunicationData>, BuyerCommunicationData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<BuyerCommunicationData>,
                BuyerCommunicationData
              >,
              AsyncValue<BuyerCommunicationData>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MonthlyVolumeNotifier)
const monthlyVolumeProvider = MonthlyVolumeNotifierProvider._();

final class MonthlyVolumeNotifierProvider
    extends $NotifierProvider<MonthlyVolumeNotifier, int> {
  const MonthlyVolumeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'monthlyVolumeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$monthlyVolumeNotifierHash();

  @$internal
  @override
  MonthlyVolumeNotifier create() => MonthlyVolumeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$monthlyVolumeNotifierHash() =>
    r'45a66e26da8a4bfcb80397f23f5b5cee6d841d4f';

abstract class _$MonthlyVolumeNotifier extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(estimatedMonthlyCost)
const estimatedMonthlyCostProvider = EstimatedMonthlyCostProvider._();

final class EstimatedMonthlyCostProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  const EstimatedMonthlyCostProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedMonthlyCostProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedMonthlyCostHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return estimatedMonthlyCost(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$estimatedMonthlyCostHash() =>
    r'a575e04828e166ac4372a1fabc5926efc50b6b92';
