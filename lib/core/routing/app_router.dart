import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/profile/presentation/screens/address_list_screen.dart';
import '../../features/profile/presentation/screens/address_form_screen.dart';
import '../../features/profile/domain/entities/address.dart';
import '../../features/auth/presentation/providers/app_boot_provider.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/laundry/presentation/screens/price_list_screen.dart';
import '../../features/order/presentation/screens/create_order_screen.dart';
import '../../features/order/presentation/screens/order_history_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_orders_screen.dart';
import '../../features/home/presentation/screens/customer_dashboard_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final bootState = ref.watch(appBootProvider);
  final roleAsync = ref.watch(userRoleProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      final isLoggingIn = state.matchedLocation == '/login';
      final isRegistering = state.matchedLocation == '/register';
      final isAuthPage = isSplash || isLoggingIn || isRegistering;

      // 1. If still booting, stay on splash or move to it
      if (bootState == AppBootState.loading) {
        return isSplash ? null : '/splash';
      }

      // 2. If unauthenticated, redirect to login unless already on auth pages
      if (bootState == AppBootState.unauthenticated) {
        if (isLoggingIn || isRegistering) return null;
        return '/login';
      }

      // 3. If authenticated, handle role-based routing
      if (bootState == AppBootState.authenticated) {
        // Requirement: If userRoleProvider is still loading, return null (stay on current page)
        if (roleAsync.isLoading) return null;

        final role = roleAsync.value;
        final currentPath = state.matchedLocation;

        if (role == 'admin') {
          // If admin is on auth pages or at the customer root (/), redirect to /admin
          if (isAuthPage || currentPath == '/') {
            return '/admin';
          }
        } else {
          // If customer is on auth pages or admin-only pages, redirect to /
          final isAdminPage = currentPath == '/admin' || currentPath == '/price-list' || currentPath == '/admin/orders';
          if (isAuthPage || isAdminPage) {
            return '/';
          }
        }
      }

      // Default: no redirect
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'customer-dashboard',
        builder: (context, state) => const CustomerDashboardScreen(),
      ),
      GoRoute(
        path: '/admin',
        name: 'admin-dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'orders',
            name: 'admin-orders',
            builder: (context, state) => const AdminOrdersScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/create-order',
        name: 'create-order',
        builder: (context, state) => const CreateOrderScreen(),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const OrderHistoryScreen(),
      ),
      GoRoute(
        path: '/price-list',
        name: 'price-list',
        builder: (context, state) => const PriceListScreen(),
      ),
      GoRoute(
        path: '/addresses',
        name: 'addresses',
        builder: (context, state) => const AddressListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'add-address',
            builder: (context, state) => const AddressFormScreen(),
          ),
          GoRoute(
            path: 'edit',
            name: 'edit-address',
            builder: (context, state) {
              final address = state.extra as AddressEntity?;
              return AddressFormScreen(address: address);
            },
          ),
        ],
      ),
    ],
  );
}
