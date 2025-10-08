import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/home/home_screen.dart';
import 'package:fashion_shop/screens/create_account/create_account_screen.dart';
import 'package:fashion_shop/screens/setting/setting_screen.dart';
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
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RouteName.setting,
        name: RouteName.setting,
        builder: (context, state) => const SettingScreen(),
      ),
    ],
  );
}
