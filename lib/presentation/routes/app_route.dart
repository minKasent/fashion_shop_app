import 'package:fashion_shop/presentation/routes/route_name.dart';
import 'package:fashion_shop/presentation/screens/login/login_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    routes: [
      GoRoute(
        path: RouteName.splash,
        name: RouteName.splash,
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
