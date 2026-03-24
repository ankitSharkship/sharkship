// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userHiveBox)
const userHiveBoxProvider = UserHiveBoxProvider._();

final class UserHiveBoxProvider
    extends $FunctionalProvider<Box<dynamic>, Box<dynamic>, Box<dynamic>>
    with $Provider<Box<dynamic>> {
  const UserHiveBoxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userHiveBoxProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userHiveBoxHash();

  @$internal
  @override
  $ProviderElement<Box<dynamic>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Box<dynamic> create(Ref ref) {
    return userHiveBox(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Box<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Box<dynamic>>(value),
    );
  }
}

String _$userHiveBoxHash() => r'8254442232adf2c3d00a8cd28020e70b60a1f804';

@ProviderFor(userRemoteDataSource)
const userRemoteDataSourceProvider = UserRemoteDataSourceProvider._();

final class UserRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          UserRemoteDataSource,
          UserRemoteDataSource,
          UserRemoteDataSource
        >
    with $Provider<UserRemoteDataSource> {
  const UserRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserRemoteDataSource create(Ref ref) {
    return userRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRemoteDataSource>(value),
    );
  }
}

String _$userRemoteDataSourceHash() =>
    r'de1c422f9f4d139d583455f6eb5e57b3a5f7b879';

@ProviderFor(userLocalDataSource)
const userLocalDataSourceProvider = UserLocalDataSourceProvider._();

final class UserLocalDataSourceProvider
    extends
        $FunctionalProvider<
          UserLocalDataSource,
          UserLocalDataSource,
          UserLocalDataSource
        >
    with $Provider<UserLocalDataSource> {
  const UserLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<UserLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserLocalDataSource create(Ref ref) {
    return userLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserLocalDataSource>(value),
    );
  }
}

String _$userLocalDataSourceHash() =>
    r'fa12d20140b4019737bf7637f3d0487e1c2db8c3';

@ProviderFor(userRepository)
const userRepositoryProvider = UserRepositoryProvider._();

final class UserRepositoryProvider
    extends $FunctionalProvider<UserRepository, UserRepository, UserRepository>
    with $Provider<UserRepository> {
  const UserRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserRepository create(Ref ref) {
    return userRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserRepository>(value),
    );
  }
}

String _$userRepositoryHash() => r'f3eeb050ca2712d78aefc985d97e4669bf71337a';

@ProviderFor(getUserDetailsUseCase)
const getUserDetailsUseCaseProvider = GetUserDetailsUseCaseProvider._();

final class GetUserDetailsUseCaseProvider
    extends
        $FunctionalProvider<
          GetUserDetailsUseCase,
          GetUserDetailsUseCase,
          GetUserDetailsUseCase
        >
    with $Provider<GetUserDetailsUseCase> {
  const GetUserDetailsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserDetailsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserDetailsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUserDetailsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserDetailsUseCase create(Ref ref) {
    return getUserDetailsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserDetailsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserDetailsUseCase>(value),
    );
  }
}

String _$getUserDetailsUseCaseHash() =>
    r'6f319ace75fc4a0f24cfcfd2a2f594d1f13d50a8';
