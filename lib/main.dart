import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'services/notification/background_notification.dart';
import 'services/notification/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // register background handler and init notification service
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await LocalNotificationService().init();

  runApp(
    const ProviderScope(
      child: PresslyApp(),
    ),
  );
}
