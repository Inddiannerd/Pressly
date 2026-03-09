import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../order/domain/entities/order.dart';
import '../../../order/presentation/providers/order_providers.dart';

class CustomerDashboardScreen extends ConsumerWidget {
  const CustomerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);
    final ordersAsync = ref.watch(userOrdersProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pressly"),
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(userOrdersProvider),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Header
              _buildHeader(theme, userAsync.value?.name, userAsync.value?.email),
              const SizedBox(height: 32),

              // Section 2: Service Modules
              Text(
                "Our Services",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildServiceGrid(context),
              const SizedBox(height: 32),

              // Section 3: Quick Actions
              _buildQuickActions(context, theme),
              const SizedBox(height: 32),

              // Section 4: Order Summary
              Text(
                "Order Summary",
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ordersAsync.when(
                data: (orders) => _buildOrderSummary(theme, orders),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text("Error loading summary: $err"),
              ),
              const SizedBox(height: 32),

              // Section 5: Recent Orders
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
                data: (orders) => _buildRecentOrders(context, theme, orders.take(3).toList()),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, String? name, String? email) {
    final displayName = name ?? (email != null ? email.split('@').first : 'User');
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/PJ_logo.png',
            height: 50,
            width: 50,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, $displayName",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Your laundry, simplified.",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    final services = [
      ('Wash & Fold', 'Regular laundry service', Icons.local_laundry_service_rounded, Colors.blue),
      ('Wash & Iron', 'Clean and crisp clothes', Icons.iron_rounded, Colors.orange),
      ('Steam Iron', 'Professional steam press', Icons.vaping_rooms_rounded, Colors.purple),
      ('Dry Clean', 'Special care for delicate wear', Icons.dry_cleaning_rounded, Colors.teal),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final (title, subtitle, icon, color) = services[index];
        return _ServiceCard(
          title: title,
          subtitle: subtitle,
          icon: icon,
          color: color,
          onTap: () => context.push('/create-order'),
        );
      },
    );
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => context.push('/create-order'),
            icon: const Icon(Icons.add_rounded),
            label: const Text("Create Order"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.push('/orders'),
            icon: const Icon(Icons.list_alt_rounded),
            label: const Text("View Orders"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: theme.colorScheme.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(ThemeData theme, List<OrderEntity> orders) {
    final pendingCount = orders.where((o) => o.status != OrderStatus.completed && o.status != OrderStatus.cancelled).length;
    final completedCount = orders.where((o) => o.status == OrderStatus.completed).length;

    return Row(
      children: [
        _SummaryCard(
          label: "Pending Orders",
          count: pendingCount.toString(),
          color: Colors.orange,
          icon: Icons.pending_actions_rounded,
        ),
        const SizedBox(width: 16),
        _SummaryCard(
          label: "Completed",
          count: completedCount.toString(),
          color: Colors.green,
          icon: Icons.check_circle_outline_rounded,
        ),
      ],
    );
  }

  Widget _buildRecentOrders(BuildContext context, ThemeData theme, List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Text(
              "No orders found. Start your first order today!",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      );
    }

    return Column(
      children: orders.map((order) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            onTap: () => context.push('/orders'),
            title: Text("Order #${order.id.substring(0, 8)}"),
            subtitle: Text(
              "${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year} • ₹${order.totalAmount}",
              style: theme.textTheme.bodySmall,
            ),
            trailing: _StatusChip(status: order.status),
          ),
        );
      }).toList(),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Spacer(),
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  final IconData icon;

  const _SummaryCard({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(
              count,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
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
        style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold),
      ),
    );
  }
}
