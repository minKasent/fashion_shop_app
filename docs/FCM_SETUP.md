# Firebase Cloud Messaging (FCM) Setup Guide

This guide explains how to use the Firebase Cloud Messaging implementation in this project.

## Features

✅ **Complete FCM Integration**

- Firebase Cloud Messaging for push notifications
- Local notifications using flutter_local_notifications
- Handles all app states: foreground, background, and terminated

✅ **Platform Support**

- Android (including Android 13+ permissions)
- iOS (with APNs integration)

✅ **Permission Handling**

- Automatic permission requests
- Permission status checking
- iOS provisional notifications support

✅ **Advanced Features**

- Topic subscription/unsubscription
- Token management and refresh
- Custom notification channels (Android)
- Notification tap handling with navigation

## Setup Instructions

### 1. Firebase Configuration

Ensure you have completed Firebase setup for both platforms:

#### Android

1. Download `google-services.json` from Firebase Console
2. Place it in `android/app/`
3. Ensure `google-services` plugin is applied in `android/app/build.gradle.kts`

#### iOS

1. Download `GoogleService-Info.plist` from Firebase Console
2. Add it to your Xcode project (Runner target)
3. Enable Push Notifications capability in Xcode:
   - Open `ios/Runner.xcworkspace`
   - Select Runner target → Signing & Capabilities
   - Click "+ Capability" → Push Notifications
4. Enable Background Modes:
   - Background fetch
   - Remote notifications

### 2. APNs Configuration (iOS Only)

1. Generate APNs Key in Apple Developer Portal:

   - Go to Certificates, Identifiers & Profiles
   - Keys → Create new key
   - Enable Apple Push Notifications service (APNs)
   - Download the .p8 key file

2. Upload APNs Key to Firebase:
   - Firebase Console → Project Settings → Cloud Messaging
   - Apple app configuration → APNs Authentication Key
   - Upload your .p8 key file

### 3. Code Generation

After making changes to injectable classes, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Usage

### Basic Usage

The `NotificationService` is automatically initialized in `main.dart`:

```dart
// Already configured in main.dart
final notificationService = getIt<NotificationService>();
await notificationService.initialize();
```

### Get FCM Token

```dart
final notificationService = getIt<NotificationService>();
final token = notificationService.fcmToken;
print('FCM Token: $token');

// Send this token to your backend server to send notifications
```

### Subscribe to Topics

```dart
final notificationService = getIt<NotificationService>();

// Subscribe
await notificationService.subscribeToTopic('all_users');
await notificationService.subscribeToTopic('promotions');

// Unsubscribe
await notificationService.unsubscribeFromTopic('promotions');
```

### Check Notification Permission

```dart
final notificationService = getIt<NotificationService>();

final isEnabled = await notificationService.areNotificationsEnabled();
if (!isEnabled) {
  // Request permission
  final granted = await notificationService.requestPermission();
  if (granted) {
    print('Permission granted!');
  }
}
```

### Listen to Notification Taps

Use the `NotificationListener` widget to handle notification taps:

```dart
// In your app.dart or main widget
NotificationListener(
  onNotificationTap: (message) {
    // Handle notification tap
    final data = message.data;

    if (data['screen'] == 'orders') {
      // Navigate to orders screen
      context.go('/orders');
    } else if (data['productId'] != null) {
      // Navigate to product detail
      context.go('/products/${data['productId']}');
    }
  },
  child: MaterialApp.router(
    routerConfig: router,
  ),
);
```

Or listen to the stream directly:

```dart
final notificationService = getIt<NotificationService>();

notificationService.onNotificationTap.listen((message) {
  print('Notification tapped: ${message.data}');
  // Handle navigation based on message.data
});
```

## Notification States

### 1. Foreground (App is Open)

- Notification received via `FirebaseMessaging.onMessage`
- Automatically displays local notification
- User can tap to interact

### 2. Background (App is in Background)

- Notification handled by system
- Tap opens app via `FirebaseMessaging.onMessageOpenedApp`
- Triggers navigation callback

### 3. Terminated (App is Closed)

- Notification handled by system
- Tap launches app
- Handled via `FirebaseMessaging.getInitialMessage()`

## Sending Test Notifications

### From Firebase Console

1. Go to Firebase Console → Cloud Messaging
2. Click "Send your first message"
3. Enter notification title and text
4. Select target (single device, topic, or user segment)
5. (Optional) Add custom data in "Additional options"

### Using Firebase Admin SDK (Backend)

```javascript
// Node.js example
const admin = require("firebase-admin");

// Send to specific device
await admin.messaging().send({
  token: deviceToken,
  notification: {
    title: "New Order",
    body: "You have a new order #12345",
  },
  data: {
    screen: "orders",
    orderId: "12345",
  },
  android: {
    priority: "high",
    notification: {
      channelId: "high_importance_channel",
    },
  },
  apns: {
    payload: {
      aps: {
        sound: "default",
        badge: 1,
      },
    },
  },
});

// Send to topic
await admin.messaging().send({
  topic: "all_users",
  notification: {
    title: "New Feature!",
    body: "Check out our latest collection",
  },
});
```

### Using HTTP API

```bash
curl -X POST https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "message": {
      "token": "DEVICE_TOKEN",
      "notification": {
        "title": "Hello",
        "body": "Test notification"
      },
      "data": {
        "screen": "home"
      }
    }
  }'
```

## Notification Payload Structure

### Recommended Structure

```json
{
  "notification": {
    "title": "Notification Title",
    "body": "Notification body text"
  },
  "data": {
    "screen": "orders",
    "orderId": "12345",
    "type": "order_update",
    "timestamp": "2025-10-16T10:00:00Z"
  }
}
```

### Data-Only Messages (Silent Notifications)

```json
{
  "data": {
    "type": "sync",
    "action": "refresh_data"
  }
}
```

## Troubleshooting

### Android

**Issue**: Notifications not showing on Android 13+
**Solution**: Ensure POST_NOTIFICATIONS permission is requested and granted

**Issue**: App crashes on notification tap
**Solution**: Check that notification channel is created before sending notifications

### iOS

**Issue**: No notifications on iOS
**Solution**:

- Verify APNs key is uploaded to Firebase
- Check that Push Notifications capability is enabled
- Ensure app is built with proper provisioning profile

**Issue**: Notifications only work in background
**Solution**: Check `FirebaseAppDelegateProxyEnabled` is set to `false` in Info.plist

### General

**Issue**: No FCM token generated
**Solution**:

- Check internet connection
- Verify Firebase configuration files are present
- Check Firebase project settings

**Issue**: Notifications not received
**Solution**:

- Verify token is valid and registered with your backend
- Check notification payload format
- Test with Firebase Console first

## Best Practices

1. **Always handle notification tap events** - Users expect to be directed to relevant content

2. **Store FCM token on your backend** - Send token to your server after initialization

3. **Handle token refresh** - Update backend when token changes

4. **Use topics for broadcast messages** - More efficient than sending to individual tokens

5. **Include meaningful data** - Add navigation data in the `data` field

6. **Test on real devices** - Notifications behave differently on emulators/simulators

7. **Handle permission denial gracefully** - Don't spam users with permission requests

8. **Use notification channels (Android)** - Allow users to customize notification preferences

## Security Notes

- Never expose FCM tokens in public repositories
- Implement proper authentication on your backend before sending notifications
- Validate notification payloads on the backend
- Use Firebase Security Rules to protect data

## Additional Resources

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [Flutter Firebase Messaging Package](https://pub.dev/packages/firebase_messaging)
- [Flutter Local Notifications Package](https://pub.dev/packages/flutter_local_notifications)
- [APNs Documentation](https://developer.apple.com/documentation/usernotifications)
