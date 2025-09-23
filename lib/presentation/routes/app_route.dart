import 'package:fashion_shop/presentation/routes/route_name.dart';
import 'package:fashion_shop/presentation/screens/home/home_screen.dart';
import 'package:fashion_shop/presentation/screens/login/login_screen.dart';
import 'package:fashion_shop/presentation/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.login,
        name: RouteName.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteName.home, // Changed from RouteName.splash to RouteName.home
        name: RouteName.home, // Changed from RouteName.splash to RouteName.home
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
