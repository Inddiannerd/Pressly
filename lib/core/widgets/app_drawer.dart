import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/auth/presentation/providers/auth_providers.dart';
import '../providers/firebase_providers.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);
    final roleAsync = ref.watch(userRoleProvider);
    final theme = Theme.of(context);

    return Drawer(
      child: Column(
        children: [
          _buildHeader(theme, userAsync.value?.email ?? ''),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.dashboard_rounded,
                  label: 'Dashboard',
                  onTap: () => context.go('/'),
                ),
                _DrawerItem(
                  icon: Icons.local_laundry_service_rounded,
                  label: 'Create Order',
                  onTap: () => context.go('/create-order'),
                ),
                _DrawerItem(
                  icon: Icons.history_rounded,
                  label: 'Orders',
                  onTap: () => context.go('/orders'),
                ),
                _DrawerItem(
                  icon: Icons.location_on_rounded,
                  label: 'Addresses',
                  onTap: () => context.go('/addresses'),
                ),
                _DrawerItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  onTap: () {
                    // Navigate to profile if route exists, else show Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile feature coming soon!')),
                    );
                    context.pop(); // Close drawer
                  },
                ),
                const Divider(),
                // Admin section
                roleAsync.when(
                  data: (role) {
                    if (role == 'admin') {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                            child: Text(
                              'ADMIN',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _DrawerItem(
                            icon: Icons.history_rounded,
                            label: 'Manage Orders',
                            onTap: () => context.go('/admin/orders'),
                          ),
                          _DrawerItem(
                            icon: Icons.receipt_long_rounded,
                            label: 'Manage Laundry Prices',
                            onTap: () => context.go('/price-list'),
                          ),
                          const Divider(),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                _DrawerItem(
                  icon: Icons.logout_rounded,
                  label: 'Logout',
                  textColor: theme.colorScheme.error,
                  iconColor: theme.colorScheme.error,
                  onTap: () async {
                    final auth = ref.read(firebaseAuthProvider);
                    await auth.signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, String email) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
      color: theme.colorScheme.primaryContainer.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/PJ_logo.png',
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Pressly',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          if (email.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              email,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: iconColor ?? theme.colorScheme.onSurfaceVariant),
      title: Text(
        label,
        style: TextStyle(
          color: textColor ?? theme.colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
