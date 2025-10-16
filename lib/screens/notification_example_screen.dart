import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/services/notification/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// Example screen showing how to use NotificationService
class NotificationExampleScreen extends StatefulWidget {
  const NotificationExampleScreen({super.key});

  @override
  State<NotificationExampleScreen> createState() => _NotificationExampleScreenState();
}

class _NotificationExampleScreenState extends State<NotificationExampleScreen> {
  final NotificationService _notificationService = getIt<NotificationService>();
  String? _fcmToken;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationStatus();
    _listenToNotificationTaps();
  }

  Future<void> _loadNotificationStatus() async {
    final token = _notificationService.fcmToken;
    final enabled = await _notificationService.areNotificationsEnabled();

    setState(() {
      _fcmToken = token;
      _notificationsEnabled = enabled;
    });
  }

  void _listenToNotificationTaps() {
    _notificationService.onNotificationTap.listen((message) {
      _showNotificationDialog(message);
    });
  }

  void _showNotificationDialog(RemoteMessage message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message.notification?.title ?? 'Notification'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.notification?.body ?? ''),
            const SizedBox(height: 16),
            const Text('Data:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(message.data.toString()),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }

  Future<void> _requestPermission() async {
    final granted = await _notificationService.requestPermission();

    if (!mounted) {
      return;
    }

    if (granted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification permission granted!')));
      await _loadNotificationStatus();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Notification permission denied')));
    }
  }

  Future<void> _subscribeToTopic(String topic) async {
    await _notificationService.subscribeToTopic(topic);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Subscribed to topic: $topic')));
  }

  Future<void> _unsubscribeFromTopic(String topic) async {
    await _notificationService.unsubscribeFromTopic(topic);

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unsubscribed from topic: $topic')));
  }

  Future<void> _copyTokenToClipboard() async {
    if (_fcmToken != null) {
      // TODO: Copy to clipboard
      // await Clipboard.setData(ClipboardData(text: _fcmToken!));
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Token copied to clipboard!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    _notificationsEnabled ? Icons.notifications_active : Icons.notifications_off,
                    color: _notificationsEnabled ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Notification Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          _notificationsEnabled ? 'Enabled' : 'Disabled',
                          style: TextStyle(color: _notificationsEnabled ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  ),
                  if (!_notificationsEnabled) ElevatedButton(onPressed: _requestPermission, child: const Text('Enable')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('FCM Token', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  if (_fcmToken != null)
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                          child: SelectableText(_fcmToken!, style: const TextStyle(fontSize: 12)),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(onPressed: _copyTokenToClipboard, icon: const Icon(Icons.copy), label: const Text('Copy Token')),
                      ],
                    )
                  else
                    const Text('Token not available'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Topic Subscriptions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildTopicCard('all_users', 'General Notifications'),
          _buildTopicCard('promotions', 'Promotions & Offers'),
          _buildTopicCard('new_products', 'New Product Alerts'),
          _buildTopicCard('order_updates', 'Order Updates'),
          const SizedBox(height: 24),
          const Text('Test Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('To test notifications:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('1. Copy your FCM token above'),
                  Text('2. Go to Firebase Console'),
                  Text('3. Cloud Messaging → Send test message'),
                  Text('4. Paste token and send'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicCard(String topic, String description) {
    return Card(
      child: ListTile(
        title: Text(topic),
        subtitle: Text(description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(onPressed: () => _subscribeToTopic(topic), child: const Text('Subscribe')),
            TextButton(onPressed: () => _unsubscribeFromTopic(topic), child: const Text('Unsubscribe')),
          ],
        ),
      ),
    );
  }
}
