import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Widget that listens to notification taps and handles navigation
/// This can be used to wrap your app's main navigator
class NotificationListener extends StatefulWidget {
  final Widget child;
  final Function(RemoteMessage message)? onNotificationTap;

  const NotificationListener({
    super.key,
    required this.child,
    this.onNotificationTap,
  });

  @override
  State<NotificationListener> createState() => _NotificationListenerState();
}

class _NotificationListenerState extends State<NotificationListener> {
  @override
  void initState() {
    super.initState();
    _setupNotificationListeners();
  }

  void _setupNotificationListeners() {
    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Handle notification tap when app was terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleNotificationTap(message);
      }
    });
  }

  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped in NotificationListener: ${message.messageId}');
    
    if (widget.onNotificationTap != null) {
      widget.onNotificationTap!(message);
    } else {
      // Default behavior: navigate based on notification data
      _navigateBasedOnNotification(message);
    }
  }

  void _navigateBasedOnNotification(RemoteMessage message) {
    final data = message.data;
    
    // Example: Handle different notification types
    if (data.containsKey('screen')) {
      final screenName = data['screen'] as String;
      debugPrint('Navigate to screen: $screenName');
      
      // TODO: Implement navigation logic based on your router
      // Example with go_router:
      // context.go('/$screenName');
    }
    
    if (data.containsKey('orderId')) {
      final orderId = data['orderId'] as String;
      debugPrint('Navigate to order: $orderId');
      
      // TODO: Navigate to order detail screen
      // context.go('/orders/$orderId');
    }
    
    if (data.containsKey('productId')) {
      final productId = data['productId'] as String;
      debugPrint('Navigate to product: $productId');
      
      // TODO: Navigate to product detail screen
      // context.go('/products/$productId');
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
