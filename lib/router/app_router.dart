import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/sign_in/sign_in_screen.dart';
import 'package:fashion_shop/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(path: RouteName.splash, name: RouteName.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RouteName.signIn, name: RouteName.signIn, builder: (context, state) => const SignInScreen()),
    ],
  );
}
