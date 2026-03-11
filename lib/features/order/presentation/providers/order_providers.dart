import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:smart_laundary/core/providers/firebase_providers.dart';
import 'package:smart_laundary/features/auth/presentation/providers/auth_providers.dart';
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
  
  final roleAsync = ref.watch(userRoleProvider);
  
  return roleAsync.when(
    data: (role) {
      if (role == 'admin') {
        return ref.watch(orderRepositoryProvider).getAllOrders().map(
          (either) => either.fold(
            (l) => throw l,
            (r) => r,
          ),
        );
      }
      return ref.watch(orderRepositoryProvider).getUserOrders(user.uid).map(
        (either) => either.fold(
          (l) => throw l,
          (r) => r,
        ),
      );
    },
    loading: () => const Stream.empty(),
    error: (err, stack) => Stream.error(err, stack),
  );
}

@riverpod
class CreateOrder extends _$CreateOrder {
  @override
  FutureOr<String?> build() => null;

  Future<void> createOrder(OrderEntity order) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(orderRepositoryProvider).createOrder(order);
      return result.fold(
        (l) => throw l,
        (r) => r,
      );
    });
  }
}

@riverpod
class UpdateOrder extends _$UpdateOrder {
  @override
  FutureOr<void> build() => null;

  Future<void> updateStatus(String orderId, OrderStatus status) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(orderRepositoryProvider).updateOrderStatus(orderId, status);
      return result.fold(
        (l) => throw l,
        (r) => r,
      );
    });
  }
}

@riverpod
class OrderItems extends _$OrderItems {
  @override
  Map<String, int> build() => {};

  void updateQuantity(String itemName, int quantity) {
    if (quantity <= 0) {
      final newState = Map<String, int>.from(state);
      newState.remove(itemName);
      state = newState;
    } else {
      state = {
        ...state,
        itemName: quantity,
      };
    }
  }

  void clear() => state = {};
}
