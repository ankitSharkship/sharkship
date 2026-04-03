// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_terms_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getTermsUsecase)
const getTermsUsecaseProvider = GetTermsUsecaseProvider._();

final class GetTermsUsecaseProvider
    extends
        $FunctionalProvider<GetTermsUsecase, GetTermsUsecase, GetTermsUsecase>
    with $Provider<GetTermsUsecase> {
  const GetTermsUsecaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTermsUsecaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTermsUsecaseHash();

  @$internal
  @override
  $ProviderElement<GetTermsUsecase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTermsUsecase create(Ref ref) {
    return getTermsUsecase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTermsUsecase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTermsUsecase>(value),
    );
  }
}

String _$getTermsUsecaseHash() => r'99e947c6ef5556f8122ad411c2e8f6bda53e9332';
