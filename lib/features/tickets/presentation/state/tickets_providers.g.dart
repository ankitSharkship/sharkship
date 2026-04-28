// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ticketsRemoteDataSource)
const ticketsRemoteDataSourceProvider = TicketsRemoteDataSourceProvider._();

final class TicketsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          TicketsRemoteDataSource,
          TicketsRemoteDataSource,
          TicketsRemoteDataSource
        >
    with $Provider<TicketsRemoteDataSource> {
  const TicketsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<TicketsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TicketsRemoteDataSource create(Ref ref) {
    return ticketsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketsRemoteDataSource>(value),
    );
  }
}

String _$ticketsRemoteDataSourceHash() =>
    r'52b1d25e99fb692dacc52e5bbe92ecc68ba7da52';

@ProviderFor(ticketsRepository)
const ticketsRepositoryProvider = TicketsRepositoryProvider._();

final class TicketsRepositoryProvider
    extends
        $FunctionalProvider<
          TicketsRepository,
          TicketsRepository,
          TicketsRepository
        >
    with $Provider<TicketsRepository> {
  const TicketsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ticketsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TicketsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TicketsRepository create(Ref ref) {
    return ticketsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TicketsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TicketsRepository>(value),
    );
  }
}

String _$ticketsRepositoryHash() => r'e857b32fc2a97598cf580e9c865ba7593691397c';

@ProviderFor(createTicketUseCase)
const createTicketUseCaseProvider = CreateTicketUseCaseProvider._();

final class CreateTicketUseCaseProvider
    extends
        $FunctionalProvider<
          CreateTicketUseCase,
          CreateTicketUseCase,
          CreateTicketUseCase
        >
    with $Provider<CreateTicketUseCase> {
  const CreateTicketUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createTicketUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createTicketUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateTicketUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateTicketUseCase create(Ref ref) {
    return createTicketUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateTicketUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateTicketUseCase>(value),
    );
  }
}

String _$createTicketUseCaseHash() =>
    r'386d86916032647678f05b5accbab4c63417c326';

@ProviderFor(getTicketsUseCase)
const getTicketsUseCaseProvider = GetTicketsUseCaseProvider._();

final class GetTicketsUseCaseProvider
    extends
        $FunctionalProvider<
          GetTicketsUseCase,
          GetTicketsUseCase,
          GetTicketsUseCase
        >
    with $Provider<GetTicketsUseCase> {
  const GetTicketsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTicketsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTicketsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTicketsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTicketsUseCase create(Ref ref) {
    return getTicketsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTicketsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTicketsUseCase>(value),
    );
  }
}

String _$getTicketsUseCaseHash() => r'49b7dba51c677ed0d88d3bca213974f4e99fd241';

@ProviderFor(ticketsList)
const ticketsListProvider = TicketsListFamily._();

final class TicketsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<TicketListResponse>,
          TicketListResponse,
          FutureOr<TicketListResponse>
        >
    with
        $FutureModifier<TicketListResponse>,
        $FutureProvider<TicketListResponse> {
  const TicketsListProvider._({
    required TicketsListFamily super.from,
    required TicketFilter super.argument,
  }) : super(
         retry: null,
         name: r'ticketsListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ticketsListHash();

  @override
  String toString() {
    return r'ticketsListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TicketListResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TicketListResponse> create(Ref ref) {
    final argument = this.argument as TicketFilter;
    return ticketsList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TicketsListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ticketsListHash() => r'13aeb859683def0305127baf4372206a74e7c4b4';

final class TicketsListFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TicketListResponse>, TicketFilter> {
  const TicketsListFamily._()
    : super(
        retry: null,
        name: r'ticketsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TicketsListProvider call(TicketFilter filter) =>
      TicketsListProvider._(argument: filter, from: this);

  @override
  String toString() => r'ticketsListProvider';
}
