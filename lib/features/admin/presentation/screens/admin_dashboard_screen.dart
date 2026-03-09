import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../order/domain/entities/order.dart';
import '../../../order/data/models/order_model.dart';

/// Provider for real-time order statistics and recent orders
final adminOrdersStreamProvider = StreamProvider<List<OrderEntity>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('orders')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => OrderModel.fromFirestore(doc).toEntity())
          .toList());
});

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);
    final ordersAsync = ref.watch(adminOrdersStreamProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Header
            _buildHeader(theme, userAsync.value?.email ?? ''),
            const SizedBox(height: 32),

            // Section 2: Business Stats
            Text(
              "Business Overview",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ordersAsync.when(
              data: (orders) => _buildStatsGrid(theme, orders),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text("Error loading stats: $err"),
            ),
            const SizedBox(height: 32),

            // Section 3: Quick Actions
            Text(
              "Quick Actions",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 32),

            // Section 4: Recent Orders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Orders",
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => context.push('/orders'),
                  child: const Text("View All"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ordersAsync.when(
              data: (orders) => _buildRecentOrders(context, theme, orders.take(5).toList()),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, String email) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/PJ_logo.png',
            height: 48,
            width: 48,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pressly Admin",
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (email.isNotEmpty)
                Text(
                  email,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(ThemeData theme, List<OrderEntity> orders) {
    final totalOrders = orders.length;
    final pendingOrders = orders.where((o) => o.status == OrderStatus.pending).length;
    final completedOrders = orders.where((o) => o.status == OrderStatus.completed).length;
    final totalRevenue = orders.fold<double>(0, (sum, o) => sum + o.totalAmount);

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          title: "Total Orders",
          value: totalOrders.toString(),
          icon: Icons.shopping_bag_outlined,
          color: Colors.blue,
        ),
        _StatCard(
          title: "Pending",
          value: pendingOrders.toString(),
          icon: Icons.pending_actions_rounded,
          color: Colors.orange,
        ),
        _StatCard(
          title: "Completed",
          value: completedOrders.toString(),
          icon: Icons.task_alt_rounded,
          color: Colors.green,
        ),
        _StatCard(
          title: "Revenue",
          value: "₹${totalRevenue.toStringAsFixed(0)}",
          icon: Icons.payments_outlined,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        _QuickActionCard(
          title: "Manage Orders",
          description: "Update status and track customer orders",
          icon: Icons.history_rounded,
          onTap: () => context.push('/admin/orders'),
        ),
        const SizedBox(height: 12),
        _QuickActionCard(
          title: "Manage Laundry Prices",
          description: "Update item lists and pricing",
          icon: Icons.receipt_long_rounded,
          onTap: () => context.push('/price-list'),
        ),
        const SizedBox(height: 12),
        _QuickActionCard(
          title: "Manage Addresses",
          description: "Edit pickup and delivery locations",
          icon: Icons.location_on_outlined,
          onTap: () => context.push('/addresses'),
        ),
      ],
    );
  }

  Widget _buildRecentOrders(BuildContext context, ThemeData theme, List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Text("No orders yet", style: theme.textTheme.bodyMedium),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            onTap: () => context.push('/orders'), // fallback since details screen isn't implemented
            title: Text("Order #${order.id.substring(0, 8)}"),
            subtitle: Text(
              "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year} • ${order.userId.substring(0, 8)}...",
              style: theme.textTheme.bodySmall,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("₹${order.totalAmount}", style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                _StatusChip(status: order.status),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: color),
                ),
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: theme.colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                    Text(description, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final OrderStatus status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case OrderStatus.pending:
        color = Colors.orange;
      case OrderStatus.picked_up:
        color = Colors.indigo;
      case OrderStatus.washing:
        color = Colors.blue;
      case OrderStatus.ironing:
        color = Colors.cyan;
      case OrderStatus.out_for_delivery:
        color = Colors.amber;
      case OrderStatus.completed:
        color = Colors.green;
      case OrderStatus.cancelled:
        color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status.name.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
