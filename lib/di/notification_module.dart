import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Dependency injection module for notification-related dependencies
@module
abstract class NotificationModule {
  /// Provides FirebaseMessaging instance
  @singleton
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  /// Provides FlutterLocalNotificationsPlugin instance
  @singleton
  FlutterLocalNotificationsPlugin get localNotifications =>
      FlutterLocalNotificationsPlugin();
}
