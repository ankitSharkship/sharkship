// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_message_transactions_usecase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getMessageTransactionsUseCase)
const getMessageTransactionsUseCaseProvider =
    GetMessageTransactionsUseCaseProvider._();

final class GetMessageTransactionsUseCaseProvider
    extends
        $FunctionalProvider<
          GetMessageTransactionsUseCase,
          GetMessageTransactionsUseCase,
          GetMessageTransactionsUseCase
        >
    with $Provider<GetMessageTransactionsUseCase> {
  const GetMessageTransactionsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getMessageTransactionsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getMessageTransactionsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetMessageTransactionsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetMessageTransactionsUseCase create(Ref ref) {
    return getMessageTransactionsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetMessageTransactionsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetMessageTransactionsUseCase>(
        value,
      ),
    );
  }
}

String _$getMessageTransactionsUseCaseHash() =>
    r'ea4c22936b1dcab3307475ca642b35819d167f31';
