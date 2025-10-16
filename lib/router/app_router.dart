import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/address/add_address_screen.dart';
import 'package:fashion_shop/screens/address/address_screen.dart';
import 'package:fashion_shop/screens/dashboard/DashboardScreen.dart';
import 'package:fashion_shop/screens/create_account/create_account_screen.dart';
import 'package:fashion_shop/screens/notification/notification_screen.dart';
import 'package:fashion_shop/screens/payment/add_card_screen.dart';
import 'package:fashion_shop/screens/payment/payment_screen.dart';
import 'package:fashion_shop/screens/sign_in/sign_in_screen.dart';
import 'package:fashion_shop/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.signIn,
        name: RouteName.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RouteName.createAccount,
        name: RouteName.createAccount,
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: RouteName.home,
        name: RouteName.home,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteName.address,
        name: RouteName.address,
        builder: (context, state) => const AddressScreen(),
      ),
      GoRoute(
        path: RouteName.addAddress,
        name: RouteName.addAddress,
        builder: (context, state) => const AddAddressScreen(),
      ),
      GoRoute(
        path: RouteName.payment,
        name: RouteName.payment,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: RouteName.addCard,
        name: RouteName.addCard,
        builder: (context, state) => const AddCardScreen(),
      ),
      GoRoute(
        path: RouteName.notification,
        name: RouteName.notification,
        builder: (context, state) => const NotificationScreen(),
      ),
    ],
  );
}
