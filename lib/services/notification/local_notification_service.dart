import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'dart:io';

class LocalNotificationService {
  static final LocalNotificationService _instance = LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    // Set local location to UTC as a default to prevent LateInitializationError.
    // Ideally, use flutter_timezone to set the actual device timezone.
    try {
      tz.setLocalLocation(tz.getLocation('UTC'));
    } catch (e) {
      // Fallback in case UTC is not found in the database
    }
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
      },
    );

    // Request permissions once
    if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    }

    _isInitialized = true;
    await scheduleDefaultNotifications();
  }

  Future<void> scheduleDefaultNotifications() async {
    if (!_isInitialized) await init();

    // 1. Weekend Reminder: Every Saturday at 9:00 AM
    await _scheduleWeekly(
      id: 101,
      title: "Laundry Weekend Reminder",
      body: "It's the weekend. Time to schedule your laundry with Pressly.",
      day: DateTime.saturday,
      hour: 9,
      minute: 0,
    );

    // 2. Midweek Reminder: Every Wednesday at 7:00 PM (19:00)
    await _scheduleWeekly(
      id: 102,
      title: "Laundry Time",
      body: "Don't forget your laundry. Open Pressly and create an order.",
      day: DateTime.wednesday,
      hour: 19,
      minute: 0,
    );
  }

  Future<void> updatePendingOrderReminder(bool hasPendingOrders) async {
    if (!_isInitialized) await init();

    const int pendingId = 103;
    if (hasPendingOrders) {
      // 3. Pending Order Reminder: Every day at 8:00 PM (20:00)
      await _scheduleDaily(
        id: pendingId,
        title: "Pending Laundry Order",
        body: "You have laundry orders waiting. Check Pressly.",
        hour: 20,
        minute: 0,
      );
    } else {
      await _notificationsPlugin.cancel(pendingId);
    }
  }

  Future<void> _scheduleWeekly({
    required int id,
    required String title,
    required String body,
    required int day,
    required int hour,
    required int minute,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfDay(day, hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_reminder_channel',
          'Weekly Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> _scheduleDaily({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOfDay(int day, int hour, int minute) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    while (scheduledDate.weekday != day) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    // If tz.local is not initialized, this will throw.
    // However, initializeTimeZones() usually initializes it to UTC or we might need setLocalLocation.
    // In many cases, we want to use the actual device timezone.
    
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
