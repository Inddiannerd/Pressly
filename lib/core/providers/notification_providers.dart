import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/order/presentation/providers/order_providers.dart';
import '../../features/order/domain/entities/order.dart';
import '../../services/notification/local_notification_service.dart';

part 'notification_providers.g.dart';

@riverpod
void notificationScheduler(NotificationSchedulerRef ref) {
  final ordersAsync = ref.watch(userOrdersProvider);

  ordersAsync.whenData((orders) {
    final hasPending = orders.any((o) => 
      o.status != OrderStatus.completed && o.status != OrderStatus.cancelled);
    
    LocalNotificationService().updatePendingOrderReminder(hasPending);
  });
}
