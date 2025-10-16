# 🚀 Quick Start Guide - Firebase Cloud Messaging

## Immediate Next Steps

### 1️⃣ Generate Code (REQUIRED)

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 2️⃣ iOS Setup (If Not Done)

Open Xcode workspace:

```bash
open ios/Runner.xcworkspace
```

Then:

1. Select Runner target → Signing & Capabilities
2. Click "+ Capability" → **Push Notifications**
3. Click "+ Capability" → **Background Modes**
   - ✅ Remote notifications
   - ✅ Background fetch

### 3️⃣ Get FCM Token

Add this temporarily to test:

```dart
// In any screen
final notificationService = getIt<NotificationService>();
print('FCM Token: ${notificationService.fcmToken}');
```

### 4️⃣ Test Notification

1. Copy the FCM token from console
2. Go to [Firebase Console](https://console.firebase.google.com)
3. Select your project → Cloud Messaging → "Send test message"
4. Paste token and send

## 📝 Quick Usage Examples

### In Your Settings Screen

```dart
import 'package:fashion_shop/shared/helpers/notification_helper.dart';

// Request permission
final granted = await NotificationHelper.ensureNotificationPermission();

// Subscribe to topics
await NotificationHelper.subscribeToUserTopics(
  receivePromotions: true,
  receiveOrderUpdates: true,
  receiveNewProducts: false,
);
```

### In Your App Widget

```dart
import 'package:fashion_shop/shared/widgets/notification_listener.dart';

@override
Widget build(BuildContext context) {
  return NotificationListener(
    onNotificationTap: (message) {
      NotificationHelper.handleNotificationNavigation(
        message,
        (route) => context.go(route),
      );
    },
    child: MaterialApp.router(
      routerConfig: router,
    ),
  );
}
```

### On Login

```dart
// Send token to backend
await NotificationHelper.sendTokenToServer();

// Subscribe to relevant topics
await NotificationHelper.subscribeToUserTopics(
  receivePromotions: user.preferences.promotions,
  receiveOrderUpdates: true,
  receiveNewProducts: user.preferences.newProducts,
);
```

### On Logout

```dart
// Unsubscribe from all topics
await NotificationHelper.unsubscribeFromAllTopics();

// Delete token
await NotificationHelper.clearNotificationToken();
```

## 🧪 Testing Checklist

### Android Testing

- [ ] Build and run on real device
- [ ] Grant notification permission when prompted
- [ ] Send test notification from Firebase Console
- [ ] Tap notification (foreground)
- [ ] Tap notification (background)
- [ ] Tap notification (terminated)
- [ ] Verify navigation works

### iOS Testing

- [ ] Configure APNs key in Firebase Console
- [ ] Enable capabilities in Xcode
- [ ] Build and run on real device (NOT simulator)
- [ ] Grant notification permission when prompted
- [ ] Test all notification states
- [ ] Verify navigation works

## 📱 Notification Payload Examples

### Simple Notification

```json
{
  "to": "YOUR_FCM_TOKEN",
  "notification": {
    "title": "New Order!",
    "body": "You have received a new order"
  }
}
```

### With Navigation Data

```json
{
  "to": "YOUR_FCM_TOKEN",
  "notification": {
    "title": "Order #12345 Shipped",
    "body": "Your order is on its way!"
  },
  "data": {
    "type": "order_update",
    "orderId": "12345",
    "screen": "orders"
  }
}
```

### To Topic

```json
{
  "to": "/topics/promotions",
  "notification": {
    "title": "50% OFF Sale!",
    "body": "Limited time offer on all items"
  },
  "data": {
    "type": "promotion",
    "promotionId": "summer_sale_2025"
  }
}
```

## 🐛 Common Issues

### "No FCM token"

- Ensure Firebase is initialized before NotificationService
- Check internet connection
- Verify google-services.json/GoogleService-Info.plist exists

### "Notifications not showing on Android"

- Grant POST_NOTIFICATIONS permission
- Check notification channel is created
- Verify app is not in "Do Not Disturb" mode

### "Notifications not working on iOS"

- Upload APNs key to Firebase Console
- Test on real device (simulator doesn't support push)
- Enable Push Notifications capability
- Check provisioning profile

### "App crashes on notification tap"

- Ensure notification data is properly formatted
- Check navigation routes exist
- Verify NotificationListener is wrapping your app

## 📚 Key Files Reference

| File                               | Purpose                                |
| ---------------------------------- | -------------------------------------- |
| `notification_service.dart`        | Main FCM service implementation        |
| `notification_helper.dart`         | Helper utilities for common operations |
| `notification_listener.dart`       | Widget for handling notification taps  |
| `notification_example_screen.dart` | Example UI showing all features        |
| `docs/FCM_SETUP.md`                | Detailed documentation                 |

## 🎯 Integration Checklist

- [x] FCM service implemented
- [x] Local notifications configured
- [x] Android permissions added
- [x] iOS capabilities documented
- [x] Dependency injection configured
- [x] Helper utilities created
- [x] Example screen provided
- [ ] Run build_runner
- [ ] Test on Android device
- [ ] Test on iOS device
- [ ] Configure APNs for iOS
- [ ] Integrate with your backend API
- [ ] Add to settings screen
- [ ] Add to login/logout flow

## 💡 Pro Tips

1. **Always test on real devices** - Especially for iOS
2. **Handle all states** - Foreground, background, terminated
3. **Include navigation data** - Users expect to be taken to relevant screens
4. **Respect user preferences** - Let users control which notifications they receive
5. **Update backend on token refresh** - Token can change over time
6. **Use topics for broadcasts** - More efficient than individual tokens
7. **Test error scenarios** - Permission denied, token null, etc.

---

**Ready to go! 🎉**

Run `flutter pub run build_runner build --delete-conflicting-outputs` and start testing!
