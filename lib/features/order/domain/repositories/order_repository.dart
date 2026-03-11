import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, String>> createOrder(OrderEntity order);
  Stream<Either<Failure, List<OrderEntity>>> getUserOrders(String userId);
  Stream<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, void>> updateOrderStatus(String orderId, OrderStatus status);
}
