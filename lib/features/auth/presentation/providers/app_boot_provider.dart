import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'auth_providers.dart';

part 'app_boot_provider.g.dart';

enum AppBootState {
  loading,
  unauthenticated,
  profileLoading,
  authenticated,
}

@riverpod
AppBootState appBoot(AppBootRef ref) {
  final authStateAsync = ref.watch(authStateProvider);
  
  return authStateAsync.when(
    data: (user) {
      if (user == null) {
        return AppBootState.unauthenticated;
      }
      return AppBootState.authenticated;
    },
    loading: () => AppBootState.loading,
    error: (_, __) => AppBootState.unauthenticated,
  );
}
