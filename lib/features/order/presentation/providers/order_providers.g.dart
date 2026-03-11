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
String _$userOrdersHash() => r'fc047a29f76787fdc2f66223ab2fc2f436847708';

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
String _$createOrderHash() => r'0c3b1f98a433ab2968caec92abc92d1065259a9b';

/// See also [CreateOrder].
@ProviderFor(CreateOrder)
final createOrderProvider =
    AutoDisposeAsyncNotifierProvider<CreateOrder, String?>.internal(
  CreateOrder.new,
  name: r'createOrderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CreateOrder = AutoDisposeAsyncNotifier<String?>;
String _$updateOrderHash() => r'b56eb18a28ba51fca51cd004e560d4c0920b83ad';

/// See also [UpdateOrder].
@ProviderFor(UpdateOrder)
final updateOrderProvider =
    AutoDisposeAsyncNotifierProvider<UpdateOrder, void>.internal(
  UpdateOrder.new,
  name: r'updateOrderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$updateOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UpdateOrder = AutoDisposeAsyncNotifier<void>;
String _$orderItemsHash() => r'9fc28713f31c868d053bb0c27617e9fba3abbe12';

/// See also [OrderItems].
@ProviderFor(OrderItems)
final orderItemsProvider =
    AutoDisposeNotifierProvider<OrderItems, Map<String, int>>.internal(
  OrderItems.new,
  name: r'orderItemsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderItems = AutoDisposeNotifier<Map<String, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
