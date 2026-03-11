import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/routing/app_router.dart';
import '../core/theme/app_theme.dart';
import '../core/providers/notification_providers.dart';

class PresslyApp extends ConsumerWidget {
  const PresslyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    
    // Initialize notification scheduler
    // ref.watch(notificationSchedulerProvider);

    return MaterialApp.router(
      title: 'Pressly',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
