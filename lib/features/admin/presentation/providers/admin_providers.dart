import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../order/domain/entities/order.dart';
import '../../../order/data/models/order_model.dart';

part 'admin_providers.g.dart';

@riverpod
Stream<List<OrderEntity>> adminOrders(AdminOrdersRef ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('orders')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc).toEntity())
          .toList());
}

@riverpod
Future<String> userEmail(UserEmailRef ref, String userId) async {
  final firestore = ref.watch(firestoreProvider);
  final doc = await firestore.collection('users').doc(userId).get();
  final data = doc.data();
  return data?['email'] ?? 'Unknown User';
}
