// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRepositoryHash() => r'bccdf3f283450e03b32ceace8289c1130f69c646';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$userOrdersHash() => r'74d016ac0011c0028502862cd3b093e92cb4a8cf';

/// See also [userOrders].
@ProviderFor(userOrders)
final userOrdersProvider =
    AutoDisposeStreamProvider<List<OrderEntity>>.internal(
  userOrders,
  name: r'userOrdersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userOrdersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserOrdersRef = AutoDisposeStreamProviderRef<List<OrderEntity>>;
String _$createOrderHash() => r'1ce5bbec400f47a08bcd44a56ae3579837725842';

/// See also [CreateOrder].
@ProviderFor(CreateOrder)
final createOrderProvider =
    AutoDisposeNotifierProvider<CreateOrder, AsyncValue<String?>>.internal(
  CreateOrder.new,
  name: r'createOrderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateOrder = AutoDisposeNotifier<AsyncValue<String?>>;
String _$updateOrderHash() => r'5aa56ed5b8cd8d7ddfb487271ba1a8bda7d7df2b';

/// See also [UpdateOrder].
@ProviderFor(UpdateOrder)
final updateOrderProvider =
    AutoDisposeNotifierProvider<UpdateOrder, AsyncValue<void>>.internal(
  UpdateOrder.new,
  name: r'updateOrderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateOrder = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
