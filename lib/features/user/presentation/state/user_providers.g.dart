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

@ProviderFor(getUserBalanceUseCase)
const getUserBalanceUseCaseProvider = GetUserBalanceUseCaseProvider._();

final class GetUserBalanceUseCaseProvider
    extends
        $FunctionalProvider<
          GetUserBalanceUseCase,
          GetUserBalanceUseCase,
          GetUserBalanceUseCase
        >
    with $Provider<GetUserBalanceUseCase> {
  const GetUserBalanceUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserBalanceUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserBalanceUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetUserBalanceUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetUserBalanceUseCase create(Ref ref) {
    return getUserBalanceUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetUserBalanceUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetUserBalanceUseCase>(value),
    );
  }
}

String _$getUserBalanceUseCaseHash() =>
    r'964057df060983a74b3db62d8dd3a68c7bbf3391';

@ProviderFor(generateOtpForPasswordUseCase)
const generateOtpForPasswordUseCaseProvider =
    GenerateOtpForPasswordUseCaseProvider._();

final class GenerateOtpForPasswordUseCaseProvider
    extends
        $FunctionalProvider<
          GenerateOtpForPasswordUseCase,
          GenerateOtpForPasswordUseCase,
          GenerateOtpForPasswordUseCase
        >
    with $Provider<GenerateOtpForPasswordUseCase> {
  const GenerateOtpForPasswordUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'generateOtpForPasswordUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$generateOtpForPasswordUseCaseHash();

  @$internal
  @override
  $ProviderElement<GenerateOtpForPasswordUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GenerateOtpForPasswordUseCase create(Ref ref) {
    return generateOtpForPasswordUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GenerateOtpForPasswordUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GenerateOtpForPasswordUseCase>(
        value,
      ),
    );
  }
}

String _$generateOtpForPasswordUseCaseHash() =>
    r'f3f96afd69ba6c90ce517fc4752bb308b0a48e8c';

@ProviderFor(changePasswordUseCase)
const changePasswordUseCaseProvider = ChangePasswordUseCaseProvider._();

final class ChangePasswordUseCaseProvider
    extends
        $FunctionalProvider<
          ChangePasswordUseCase,
          ChangePasswordUseCase,
          ChangePasswordUseCase
        >
    with $Provider<ChangePasswordUseCase> {
  const ChangePasswordUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changePasswordUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changePasswordUseCaseHash();

  @$internal
  @override
  $ProviderElement<ChangePasswordUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChangePasswordUseCase create(Ref ref) {
    return changePasswordUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangePasswordUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangePasswordUseCase>(value),
    );
  }
}

String _$changePasswordUseCaseHash() =>
    r'e811710553f9a7bcf25f23e510bc6588c7fbdd21';

@ProviderFor(updatePersonalInfoUseCase)
const updatePersonalInfoUseCaseProvider = UpdatePersonalInfoUseCaseProvider._();

final class UpdatePersonalInfoUseCaseProvider
    extends
        $FunctionalProvider<
          UpdatePersonalInfoUseCase,
          UpdatePersonalInfoUseCase,
          UpdatePersonalInfoUseCase
        >
    with $Provider<UpdatePersonalInfoUseCase> {
  const UpdatePersonalInfoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updatePersonalInfoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updatePersonalInfoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdatePersonalInfoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdatePersonalInfoUseCase create(Ref ref) {
    return updatePersonalInfoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdatePersonalInfoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdatePersonalInfoUseCase>(value),
    );
  }
}

String _$updatePersonalInfoUseCaseHash() =>
    r'fbf83792821905226f413b83a62655a14e211971';

@ProviderFor(uploadLogoUseCase)
const uploadLogoUseCaseProvider = UploadLogoUseCaseProvider._();

final class UploadLogoUseCaseProvider
    extends
        $FunctionalProvider<
          UploadLogoUseCase,
          UploadLogoUseCase,
          UploadLogoUseCase
        >
    with $Provider<UploadLogoUseCase> {
  const UploadLogoUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uploadLogoUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uploadLogoUseCaseHash();

  @$internal
  @override
  $ProviderElement<UploadLogoUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UploadLogoUseCase create(Ref ref) {
    return uploadLogoUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UploadLogoUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UploadLogoUseCase>(value),
    );
  }
}

String _$uploadLogoUseCaseHash() => r'70a54cfad27b105d375f78d6ecd8c81d3ce055c2';
