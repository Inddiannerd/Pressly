import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_laundary/core/providers/firebase_providers.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';

part 'order_providers.g.dart';

@riverpod
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepositoryImpl(ref.watch(firestoreProvider));
}

@riverpod
Stream<List<OrderEntity>> userOrders(UserOrdersRef ref) {
  final user = ref.watch(firebaseAuthProvider).currentUser;
  if (user == null) return Stream.value([]);
  
  return ref.watch(orderRepositoryProvider).getUserOrders(user.uid).map(
    (either) => either.fold(
      (l) => throw l,
      (r) => r,
    ),
  );
}

@riverpod
class CreateOrder extends _$CreateOrder {
  @override
  AsyncValue<String?> build() {
    return const AsyncValue.data(null);
  }

  Future<void> createOrder(OrderEntity order) async {
    state = const AsyncValue.loading();
    final result = await ref.read(orderRepositoryProvider).createOrder(order);
    
    state = result.fold(
      (l) => AsyncValue.error(l.message, StackTrace.current),
      (r) => AsyncValue.data(r),
    );
  }
}

@riverpod
class UpdateOrder extends _$UpdateOrder {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> updateStatus(String orderId, OrderStatus status) async {
    state = const AsyncValue.loading();
    final result = await ref.read(orderRepositoryProvider).updateOrderStatus(orderId, status);
    
    state = result.fold(
      (l) => AsyncValue.error(l.message, StackTrace.current),
      (r) => const AsyncValue.data(null),
    );
  }
}
