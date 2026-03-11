import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepositoryImpl(this._firestore);

  @override
  Future<Either<Failure, String>> createOrder(OrderEntity order) async {
    try {
      final model = OrderModel.fromEntity(order);
      final docRef = await _firestore.collection('orders').add(model.toFirestore());
      return right(docRef.id);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<OrderEntity>>> getUserOrders(String userId) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      try {
        final orders = snapshot.docs
            .map((doc) => OrderModel.fromFirestore(doc).toEntity())
            .toList();
        return right(orders);
      } catch (e) {
        return left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Stream<Either<Failure, List<OrderEntity>>> getAllOrders() {
    return _firestore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      try {
        final orders = snapshot.docs
            .map((doc) => OrderModel.fromFirestore(doc).toEntity())
            .toList();
        return right(orders);
      } catch (e) {
        return left(ServerFailure(e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({'status': status.name});
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
