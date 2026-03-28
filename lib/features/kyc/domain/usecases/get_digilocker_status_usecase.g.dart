// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_digilocker_status_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getDigilockerStatusUseCase)
const getDigilockerStatusUseCaseProvider =
    GetDigilockerStatusUseCaseProvider._();

final class GetDigilockerStatusUseCaseProvider
    extends
        $FunctionalProvider<
          GetDigilockerStatusUseCase,
          GetDigilockerStatusUseCase,
          GetDigilockerStatusUseCase
        >
    with $Provider<GetDigilockerStatusUseCase> {
  const GetDigilockerStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getDigilockerStatusUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getDigilockerStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetDigilockerStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetDigilockerStatusUseCase create(Ref ref) {
    return getDigilockerStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetDigilockerStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetDigilockerStatusUseCase>(value),
    );
  }
}

String _$getDigilockerStatusUseCaseHash() =>
    r'0e017b777a2060556ae06c2d1bf6a183fa95d39a';
