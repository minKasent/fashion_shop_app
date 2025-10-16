import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/services/notification/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// Utility class for common notification operations
class NotificationHelper {
  static final NotificationService _notificationService = getIt<NotificationService>();

  /// Send FCM token to your backend server
  static Future<void> sendTokenToServer() async {
    final token = _notificationService.fcmToken;
    if (token != null) {
      // TODO: Implement your API call to send token to backend
      // Example:
      // await apiService.updateFcmToken(token);
      print('FCM Token to send to server: $token');
    }
  }

  /// Subscribe to user-specific topics based on preferences
  static Future<void> subscribeToUserTopics({
    required bool receivePromotions,
    required bool receiveOrderUpdates,
    required bool receiveNewProducts,
  }) async {
    if (receivePromotions) {
      await _notificationService.subscribeToTopic('promotions');
    } else {
      await _notificationService.unsubscribeFromTopic('promotions');
    }

    if (receiveOrderUpdates) {
      await _notificationService.subscribeToTopic('order_updates');
    } else {
      await _notificationService.unsubscribeFromTopic('order_updates');
    }

    if (receiveNewProducts) {
      await _notificationService.subscribeToTopic('new_products');
    } else {
      await _notificationService.unsubscribeFromTopic('new_products');
    }

    // Always subscribe to critical updates
    await _notificationService.subscribeToTopic('all_users');
  }

  /// Handle notification navigation based on data
  static void handleNotificationNavigation(RemoteMessage message, Function(String route) navigateTo) {
    final data = message.data;

    if (data.isEmpty) {
      return;
    }

    // Handle different notification types
    final notificationType = data['type'] as String?;

    switch (notificationType) {
      case 'order_update':
        final orderId = data['orderId'] as String?;
        if (orderId != null) {
          navigateTo('/orders/$orderId');
        }
        break;

      case 'product_announcement':
        final productId = data['productId'] as String?;
        if (productId != null) {
          navigateTo('/products/$productId');
        }
        break;

      case 'promotion':
        final promotionId = data['promotionId'] as String?;
        if (promotionId != null) {
          navigateTo('/promotions/$promotionId');
        }
        break;

      case 'general':
      default:
        final screen = data['screen'] as String?;
        if (screen != null) {
          navigateTo('/$screen');
        }
        break;
    }
  }

  /// Check and request notification permission if needed
  static Future<bool> ensureNotificationPermission() async {
    final isEnabled = await _notificationService.areNotificationsEnabled();

    if (!isEnabled) {
      return await _notificationService.requestPermission();
    }

    return true;
  }

  /// Unsubscribe from all topics (useful on logout)
  static Future<void> unsubscribeFromAllTopics() async {
    await _notificationService.unsubscribeFromTopic('all_users');
    await _notificationService.unsubscribeFromTopic('promotions');
    await _notificationService.unsubscribeFromTopic('order_updates');
    await _notificationService.unsubscribeFromTopic('new_products');
  }

  /// Delete FCM token (useful on logout)
  static Future<void> clearNotificationToken() async {
    await _notificationService.deleteToken();
  }

  /// Get current FCM token
  static String? getToken() {
    return _notificationService.fcmToken;
  }

  /// Check if notifications are enabled
  static Future<bool> areNotificationsEnabled() async {
    return await _notificationService.areNotificationsEnabled();
  }
}
