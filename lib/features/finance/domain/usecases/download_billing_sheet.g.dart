// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_billing_sheet.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DownloadBillingSheetUseCase)
const downloadBillingSheetUseCaseProvider =
    DownloadBillingSheetUseCaseProvider._();

final class DownloadBillingSheetUseCaseProvider
    extends
        $NotifierProvider<
          DownloadBillingSheetUseCase,
          DownloadBillingSheetUseCase
        > {
  const DownloadBillingSheetUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'downloadBillingSheetUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$downloadBillingSheetUseCaseHash();

  @$internal
  @override
  DownloadBillingSheetUseCase create() => DownloadBillingSheetUseCase();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DownloadBillingSheetUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DownloadBillingSheetUseCase>(value),
    );
  }
}

String _$downloadBillingSheetUseCaseHash() =>
    r'459bea281249f2ae1a1b3e03a7e05a4619811482';

abstract class _$DownloadBillingSheetUseCase
    extends $Notifier<DownloadBillingSheetUseCase> {
  DownloadBillingSheetUseCase build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<DownloadBillingSheetUseCase, DownloadBillingSheetUseCase>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                DownloadBillingSheetUseCase,
                DownloadBillingSheetUseCase
              >,
              DownloadBillingSheetUseCase,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
