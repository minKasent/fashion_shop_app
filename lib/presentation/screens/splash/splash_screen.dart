import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/presentation/routes/route_name.dart';
import 'package:fashion_shop/presentation/theme/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/datasource/local/secure_storage.dart';
import '../../../di/injector.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage secureStorage = getIt<SecureStorage>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      final accessToken = await secureStorage.getAccessToken();
      if (mounted) {
        if (accessToken != null && accessToken.isNotEmpty) {
          context.go(RouteName.login);
        } else {
          context.go(RouteName.splash);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      context.go(RouteName.login);
    });
    return Scaffold(
      backgroundColor: AppColorSchemes.purple,
      body: Center(
        child: Image(image: Assets.images.logoImg.provider()),
      ),
    );
  }
}
















