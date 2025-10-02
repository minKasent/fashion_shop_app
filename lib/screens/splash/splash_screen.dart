import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go(RouteName.signIn);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.purple,
      body: Center(child: Image(image: Assets.images.logoImg.provider())),
    );
  }
}
