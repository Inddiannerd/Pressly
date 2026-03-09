import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_laundary/features/auth/presentation/providers/auth_providers.dart';
import 'package:smart_laundary/core/providers/firebase_providers.dart';
import '../../../core/widgets/app_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);
    final roleAsync = ref.watch(userRoleProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pressly"),
      ),
      drawer: const AppDrawer(),
      body: userAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_rounded, color: theme.colorScheme.error, size: 48),
                const SizedBox(height: 16),
                Text(
                  "Something went wrong",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(userProfileProvider),
                  child: const Text("Retry"),
                ),
              ],
            ),
          ),
        ),
        data: (user) {
          final displayName = user?.name ?? (user?.email != null ? user!.email.split('@').first : 'User');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, $displayName",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "What would you like to do today?",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                _ActionCard(
                  title: "Manage Addresses",
                  description: "Add or edit your pickup and delivery locations",
                  icon: Icons.location_on_rounded,
                  onTap: () => context.push('/addresses'),
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  title: "Create Order",
                  description: "Schedule a new laundry pickup",
                  icon: Icons.local_laundry_service_rounded,
                  onTap: () => context.push('/create-order'),
                ),
                const SizedBox(height: 16),
                _ActionCard(
                  title: "Order History",
                  description: "Track and view your previous laundry services",
                  icon: Icons.history_rounded,
                  onTap: () => context.push('/orders'),
                ),
                // Admin only section
                roleAsync.when(
                  data: (role) {
                    if (role == 'admin') {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: _ActionCard(
                          title: "Laundry Prices",
                          description: "Manage laundry items and pricing (Admin)",
                          icon: Icons.receipt_long_rounded,
                          onTap: () => context.push('/price-list'),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: theme.colorScheme.onPrimaryContainer,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}