// lib/services/notification/background_notification.dart
//
// Lightweight, safe FCM background handler + helper init.
// This file MUST be top-level (no classes used as the background handler).
// Keep it minimal to avoid issues in background isolates.

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:developer' as developer;

/// Top-level background message handler required by firebase_messaging.
/// Must be a top-level function (not a closure or class method).
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized in the background isolate.
  // `initializeApp` is idempotent and cheap if already initialized.
  try {
    await Firebase.initializeApp();
  } catch (e, st) {
    developer.log('Firebase.initializeApp() in bg handler failed: $e', error: e, stackTrace: st);
  }

  // Minimal handling: log the incoming message. Expand later if needed.
  developer.log('FCM background message received: ${message.messageId} - ${message.data}');
}
  
/// Minimal NotificationService to centralize messaging initialization.
/// Keep side-effects out of constructors; call init() explicitly from main().
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Call once at app startup (after Firebase.initializeApp()).
  Future<void> init() async {
    try {
      // Request permissions on iOS / macOS. On Android this is no-op for most versions.
      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // Optional: print token for debugging
      final token = await _messaging.getToken();
      developer.log('FCM token: $token');

      // Handle foreground messages (optional runtime handler)
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        developer.log('FCM foreground message: ${message.messageId} ${message.notification?.title}');
      });

      // Background handler must be set from the main isolate
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } catch (e, st) {
      developer.log('NotificationService.init() failed: $e', error: e, stackTrace: st);
    }
  }
}
