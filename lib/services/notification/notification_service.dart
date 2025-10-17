import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

/// Top-level function to handle background messages
/// This must be a top-level function and cannot be anonymous
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint('Message data: ${message.data}');
  debugPrint('Message notification: ${message.notification?.title}');
}

/// Service responsible for handling Firebase Cloud Messaging and local notifications
/// Manages notification permissions, foreground/background/terminated state handling
@singleton
class NotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  /// Stream controller for handling notification tap events
  final StreamController<RemoteMessage> _notificationTapStreamController = StreamController<RemoteMessage>.broadcast();

  /// Stream that emits when a notification is tapped
  Stream<RemoteMessage> get onNotificationTap => _notificationTapStreamController.stream;

  String? _fcmToken;

  /// Current FCM token for this device
  String? get fcmToken => _fcmToken;

  NotificationService(this._firebaseMessaging, this._localNotifications);

  /// Initialize the notification service
  /// This should be called during app startup
  Future<void> initialize() async {
    try {
      // Configure local notifications
      await _initializeLocalNotifications();

      // Request permission for notifications
      await requestPermission();

      // Get and store FCM token
      await _initializeFCMToken();

      // Set up foreground notification presentation options
      await _configureForegroundNotifications();

      // Set up message handlers
      _setupMessageHandlers();

      // Handle notification that launched the app from terminated state
      await _handleInitialMessage();

      debugPrint('NotificationService initialized successfully');
    } catch (error, stackTrace) {
      debugPrint('Error initializing NotificationService: $error');
      debugPrint('StackTrace: $stackTrace');
    }
  }

  /// Initialize local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    const androidInitialize = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitialize = DarwinInitializationSettings(requestAlertPermission: false, requestBadgePermission: false, requestSoundPermission: false);

    const initializationSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: _onDidReceiveBackgroundNotificationResponse,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _createAndroidNotificationChannel();
    }
  }

  /// Create notification channel for Android
  Future<void> _createAndroidNotificationChannel() async {
    const androidChannel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // name
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
    );

    await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(
      androidChannel,
    );
  }

  /// Request notification permissions from the user
  Future<bool> requestPermission() async {
    try {
      // Request iOS permissions
      if (Platform.isIOS) {
        final settings = await _firebaseMessaging.requestPermission(
          alert: true,
          badge: true,
          sound: true,
          provisional: false,
          criticalAlert: false,
          announcement: false,
          carPlay: false,
        );

        debugPrint('iOS notification permission status: ${settings.authorizationStatus}');
        return settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional;
      }

      // Request Android permissions (for Android 13+)
      if (Platform.isAndroid) {
        final androidImplementation = _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

        final granted = await androidImplementation?.requestNotificationsPermission();
        debugPrint('Android notification permission granted: $granted');
        return granted ?? true; // Default to true for older Android versions
      }

      return true;
    } catch (error) {
      debugPrint('Error requesting notification permission: $error');
      return false;
    }
  }

  /// Initialize and retrieve FCM token
  Future<void> _initializeFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $_fcmToken');

      /// Send token to your server if needed

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        debugPrint('FCM Token refreshed: $newToken');
        // TODO: Send token to your server
      });
    } catch (error) {
      debugPrint('Error getting FCM token: $error');
    }
  }

  /// Configure how notifications are presented in the foreground
  Future<void> _configureForegroundNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
  }

  /// Set up message handlers for different app states
  void _setupMessageHandlers() {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages (when app is in background but not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    // Set background message handler (for terminated state)
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  /// Handle messages when app is in foreground
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Foreground message received: ${message.messageId}');
    debugPrint('Message data: ${message.data}');

    // Display local notification when in foreground
    await _showLocalNotification(message);
  }

  /// Handle messages when app is opened from background
  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint('Background message opened: ${message.messageId}');
    _notificationTapStreamController.add(message);
  }

  /// Handle notification that launched the app from terminated state
  Future<void> _handleInitialMessage() async {
    final initialMessage = await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      debugPrint('App opened from terminated state: ${initialMessage.messageId}');
      _notificationTapStreamController.add(initialMessage);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;

      if (notification == null) {
        return;
      }

      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
      );

      const iosDetails = DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true);

      const notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetails,
        payload: message.data.toString(),
      );
    } catch (error) {
      debugPrint('Error showing local notification: $error');
    }
  }

  /// Handle notification tap from foreground
  void _onDidReceiveNotificationResponse(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.payload}');
    // Create a RemoteMessage-like object from payload if needed
    // For now, just log it
  }

  /// Handle notification tap from background (static method required)
  @pragma('vm:entry-point')
  static void _onDidReceiveBackgroundNotificationResponse(NotificationResponse response) {
    debugPrint('Background notification tapped: ${response.payload}');
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      debugPrint('Subscribed to topic: $topic');
    } catch (error) {
      debugPrint('Error subscribing to topic: $error');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      debugPrint('Unsubscribed from topic: $topic');
    } catch (error) {
      debugPrint('Error unsubscribing from topic: $error');
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      debugPrint('FCM token deleted');
    } catch (error) {
      debugPrint('Error deleting FCM token: $error');
    }
  }

  /// Get current notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    return await _firebaseMessaging.getNotificationSettings();
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final settings = await getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  /// Dispose resources
  void dispose() {
    _notificationTapStreamController.close();
  }
}
