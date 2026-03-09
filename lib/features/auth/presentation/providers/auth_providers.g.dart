// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRemoteDataSourceHash() =>
    r'e57eb2732f2790446eb98a38714f6330644599bd';

/// See also [authRemoteDataSource].
@ProviderFor(authRemoteDataSource)
final authRemoteDataSourceProvider =
    AutoDisposeProvider<AuthRemoteDataSource>.internal(
  authRemoteDataSource,
  name: r'authRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRemoteDataSourceRef = AutoDisposeProviderRef<AuthRemoteDataSource>;
String _$userFirestoreDataSourceHash() =>
    r'0318c76d347ea383f103921c0731d1e6416849a4';

/// See also [userFirestoreDataSource].
@ProviderFor(userFirestoreDataSource)
final userFirestoreDataSourceProvider =
    AutoDisposeProvider<UserFirestoreDataSource>.internal(
  userFirestoreDataSource,
  name: r'userFirestoreDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userFirestoreDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserFirestoreDataSourceRef
    = AutoDisposeProviderRef<UserFirestoreDataSource>;
String _$authRepositoryHash() => r'd9a582428c1dc3c279308f3c024661d7efbff208';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$signInWithEmailUseCaseHash() =>
    r'7529a48dd5ff84e91a215dd09e27d8dff8a530f9';

/// See also [signInWithEmailUseCase].
@ProviderFor(signInWithEmailUseCase)
final signInWithEmailUseCaseProvider =
    AutoDisposeProvider<SignInWithEmail>.internal(
  signInWithEmailUseCase,
  name: r'signInWithEmailUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signInWithEmailUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignInWithEmailUseCaseRef = AutoDisposeProviderRef<SignInWithEmail>;
String _$signUpWithEmailUseCaseHash() =>
    r'3e5b4f10dcb3fea482861c9d12c4d7be9b85bc3b';

/// See also [signUpWithEmailUseCase].
@ProviderFor(signUpWithEmailUseCase)
final signUpWithEmailUseCaseProvider =
    AutoDisposeProvider<SignUpWithEmail>.internal(
  signUpWithEmailUseCase,
  name: r'signUpWithEmailUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$signUpWithEmailUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignUpWithEmailUseCaseRef = AutoDisposeProviderRef<SignUpWithEmail>;
String _$authStateHash() => r'd914e8ba7a6243b1241264c25539f18deb0389bc';

/// See also [authState].
@ProviderFor(authState)
final authStateProvider = AutoDisposeStreamProvider<auth.User?>.internal(
  authState,
  name: r'authStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthStateRef = AutoDisposeStreamProviderRef<auth.User?>;
String _$userProfileHash() => r'c3480382b661ff6589662be08827520746243006';

/// See also [userProfile].
@ProviderFor(userProfile)
final userProfileProvider = AutoDisposeStreamProvider<UserEntity?>.internal(
  userProfile,
  name: r'userProfileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserProfileRef = AutoDisposeStreamProviderRef<UserEntity?>;
String _$userRoleHash() => r'2141c17f7c67cf2aca701566c842e2d977b92092';

/// See also [userRole].
@ProviderFor(userRole)
final userRoleProvider = AutoDisposeStreamProvider<String>.internal(
  userRole,
  name: r'userRoleProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userRoleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRoleRef = AutoDisposeStreamProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
