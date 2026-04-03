// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'init_digilocker_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(initDigilockerUseCase)
const initDigilockerUseCaseProvider = InitDigilockerUseCaseProvider._();

final class InitDigilockerUseCaseProvider
    extends
        $FunctionalProvider<
          InitDigilockerUseCase,
          InitDigilockerUseCase,
          InitDigilockerUseCase
        >
    with $Provider<InitDigilockerUseCase> {
  const InitDigilockerUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initDigilockerUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initDigilockerUseCaseHash();

  @$internal
  @override
  $ProviderElement<InitDigilockerUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InitDigilockerUseCase create(Ref ref) {
    return initDigilockerUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InitDigilockerUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InitDigilockerUseCase>(value),
    );
  }
}

String _$initDigilockerUseCaseHash() =>
    r'a32cd198c57d462d963764c54e675d5b0d943b91';
