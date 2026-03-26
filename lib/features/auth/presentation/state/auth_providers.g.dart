// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRemoteDataSource)
const authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  const AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'adab13c1c7d7042c10ccc3c40b4b7cf3123cf0ee';

@ProviderFor(authLocalDataSource)
const authLocalDataSourceProvider = AuthLocalDataSourceProvider._();

final class AuthLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AuthLocalDataSource,
          AuthLocalDataSource,
          AuthLocalDataSource
        >
    with $Provider<AuthLocalDataSource> {
  const AuthLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthLocalDataSource create(Ref ref) {
    return authLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthLocalDataSource>(value),
    );
  }
}

String _$authLocalDataSourceHash() =>
    r'721736a8b234668c05ad332b4d18cfecd0159820';

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'7f565152a1b28d457463aea0b1fed4ef22b9861e';

@ProviderFor(generateOtpUseCase)
const generateOtpUseCaseProvider = GenerateOtpUseCaseProvider._();

final class GenerateOtpUseCaseProvider
    extends
        $FunctionalProvider<
          GenerateOtpUseCase,
          GenerateOtpUseCase,
          GenerateOtpUseCase
        >
    with $Provider<GenerateOtpUseCase> {
  const GenerateOtpUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateOtpUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateOtpUseCaseHash();

  @$internal
  @override
  $ProviderElement<GenerateOtpUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GenerateOtpUseCase create(Ref ref) {
    return generateOtpUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateOtpUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateOtpUseCase>(value),
    );
  }
}

String _$generateOtpUseCaseHash() =>
    r'6c48e2e6a27d87ecf6b24378a71c4eb6901cb23d';

@ProviderFor(otpLoginUseCase)
const otpLoginUseCaseProvider = OtpLoginUseCaseProvider._();

final class OtpLoginUseCaseProvider
    extends
        $FunctionalProvider<OtpLoginUseCase, OtpLoginUseCase, OtpLoginUseCase>
    with $Provider<OtpLoginUseCase> {
  const OtpLoginUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'otpLoginUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$otpLoginUseCaseHash();

  @$internal
  @override
  $ProviderElement<OtpLoginUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  OtpLoginUseCase create(Ref ref) {
    return otpLoginUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OtpLoginUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OtpLoginUseCase>(value),
    );
  }
}

String _$otpLoginUseCaseHash() => r'26b02ad48d6d06d1248a4d8422a97c2f2b34d4bb';

@ProviderFor(passwordLoginUseCase)
const passwordLoginUseCaseProvider = PasswordLoginUseCaseProvider._();

final class PasswordLoginUseCaseProvider
    extends
        $FunctionalProvider<
          PasswordLoginUseCase,
          PasswordLoginUseCase,
          PasswordLoginUseCase
        >
    with $Provider<PasswordLoginUseCase> {
  const PasswordLoginUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordLoginUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordLoginUseCaseHash();

  @$internal
  @override
  $ProviderElement<PasswordLoginUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PasswordLoginUseCase create(Ref ref) {
    return passwordLoginUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PasswordLoginUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PasswordLoginUseCase>(value),
    );
  }
}

String _$passwordLoginUseCaseHash() =>
    r'80bca18ffbec8b0df3de669036234b6a8cbdf756';

@ProviderFor(logoutUseCase)
const logoutUseCaseProvider = LogoutUseCaseProvider._();

final class LogoutUseCaseProvider
    extends $FunctionalProvider<LogoutUseCase, LogoutUseCase, LogoutUseCase>
    with $Provider<LogoutUseCase> {
  const LogoutUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'logoutUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$logoutUseCaseHash();

  @$internal
  @override
  $ProviderElement<LogoutUseCase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LogoutUseCase create(Ref ref) {
    return logoutUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LogoutUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LogoutUseCase>(value),
    );
  }
}

String _$logoutUseCaseHash() => r'67224f00aebb158eab2aba2c4398e98150dd958c';

@ProviderFor(authenticateUserUseCase)
const authenticateUserUseCaseProvider = AuthenticateUserUseCaseProvider._();

final class AuthenticateUserUseCaseProvider
    extends
        $FunctionalProvider<
          AuthenticateUserUseCase,
          AuthenticateUserUseCase,
          AuthenticateUserUseCase
        >
    with $Provider<AuthenticateUserUseCase> {
  const AuthenticateUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authenticateUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authenticateUserUseCaseHash();

  @$internal
  @override
  $ProviderElement<AuthenticateUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthenticateUserUseCase create(Ref ref) {
    return authenticateUserUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthenticateUserUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthenticateUserUseCase>(value),
    );
  }
}

String _$authenticateUserUseCaseHash() =>
    r'53905beaacd7d2b4eec6d69acbd497305195e1e1';

@ProviderFor(registerUserUseCase)
const registerUserUseCaseProvider = RegisterUserUseCaseProvider._();

final class RegisterUserUseCaseProvider
    extends
        $FunctionalProvider<
          RegisterUserUseCase,
          RegisterUserUseCase,
          RegisterUserUseCase
        >
    with $Provider<RegisterUserUseCase> {
  const RegisterUserUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerUserUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerUserUseCaseHash();

  @$internal
  @override
  $ProviderElement<RegisterUserUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegisterUserUseCase create(Ref ref) {
    return registerUserUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterUserUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterUserUseCase>(value),
    );
  }
}

String _$registerUserUseCaseHash() =>
    r'9fde872e9b1222f61db4975e0fe64267fcc23504';
