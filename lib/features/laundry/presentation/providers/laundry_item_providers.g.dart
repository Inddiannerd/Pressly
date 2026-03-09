// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laundry_item_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$laundryItemRepositoryHash() =>
    r'1e005b3b345c81d1d3c527eb7ecb04337721fb52';

/// See also [laundryItemRepository].
@ProviderFor(laundryItemRepository)
final laundryItemRepositoryProvider =
    AutoDisposeProvider<LaundryItemRepository>.internal(
  laundryItemRepository,
  name: r'laundryItemRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$laundryItemRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LaundryItemRepositoryRef
    = AutoDisposeProviderRef<LaundryItemRepository>;
String _$laundryItemsHash() => r'f24c7a35436994055817e2b349b35a0bfcddd685';

/// See also [laundryItems].
@ProviderFor(laundryItems)
final laundryItemsProvider =
    AutoDisposeStreamProvider<List<LaundryItemEntity>>.internal(
  laundryItems,
  name: r'laundryItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$laundryItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LaundryItemsRef = AutoDisposeStreamProviderRef<List<LaundryItemEntity>>;
String _$laundryItemControllerHash() =>
    r'274fb9d9306ca5fb8bf69b3e0ae44c68e5a4bd15';

/// See also [LaundryItemController].
@ProviderFor(LaundryItemController)
final laundryItemControllerProvider = AutoDisposeNotifierProvider<
    LaundryItemController, AsyncValue<void>>.internal(
  LaundryItemController.new,
  name: r'laundryItemControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$laundryItemControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LaundryItemController = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
