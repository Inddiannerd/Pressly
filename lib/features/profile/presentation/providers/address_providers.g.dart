// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addressRemoteDataSourceHash() =>
    r'817c69cb82665690deb7e382410b704706a5e000';

/// See also [addressRemoteDataSource].
@ProviderFor(addressRemoteDataSource)
final addressRemoteDataSourceProvider =
    AutoDisposeProvider<AddressRemoteDataSource>.internal(
  addressRemoteDataSource,
  name: r'addressRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addressRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddressRemoteDataSourceRef
    = AutoDisposeProviderRef<AddressRemoteDataSource>;
String _$addressRepositoryHash() => r'035aa3788eb78e0513eaa7a24466c88c2faf50e9';

/// See also [addressRepository].
@ProviderFor(addressRepository)
final addressRepositoryProvider =
    AutoDisposeProvider<AddressRepository>.internal(
  addressRepository,
  name: r'addressRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addressRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddressRepositoryRef = AutoDisposeProviderRef<AddressRepository>;
String _$userAddressesHash() => r'dc09c8c6bc016639705f70f84805b76bb7a669bf';

/// See also [userAddresses].
@ProviderFor(userAddresses)
final userAddressesProvider =
    AutoDisposeFutureProvider<List<AddressEntity>>.internal(
  userAddresses,
  name: r'userAddressesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userAddressesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserAddressesRef = AutoDisposeFutureProviderRef<List<AddressEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
