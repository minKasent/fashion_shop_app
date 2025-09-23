import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/presentation/routes/route_name.dart';
import 'package:fashion_shop/presentation/shared/app_text.dart';
import 'package:fashion_shop/presentation/theme/app_color_schemes.dart';
import 'package:fashion_shop/presentation/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../shared/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            AppText(content: "Sign in"),
            SizedBox(height: 20.h),
            AppTextField(hinText: 'Email Address'),
            SizedBox(height: 25.h),
            AppTextField(hinText: 'Password'),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsetsGeometry.symmetric(vertical: 17.h),
              width: 390.w - 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColorSchemes.purple,
              ),
              child: GestureDetector(
                onTap: () {
                  context.go(RouteName.home);
                },
                child: AppText(
                  content: "Continue",
                  style: AppTypography.text16w500,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            AppText(
              content: "Don't have an account? Sign up",
              style: AppTypography.text12w450,
            ),
            SizedBox(height: 50.h),
            _buildLoginWidget(
              iconPath: Assets.icons.apple.path,
              title: 'Continue With Apple',
            ),
            SizedBox(height: 20.h),
            _buildLoginWidget(
              iconPath: Assets.icons.google.path,
              title: 'Continue With Google',
            ),
            SizedBox(height: 20.h),
            _buildLoginWidget(
              iconPath: Assets.icons.facebook.path,
              title: 'Continue With Facebook',
            ),
          ],
        ),
      ),
    );
  }

  Container _buildLoginWidget({
    required String iconPath,
    required String title,
  }) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(vertical: 17.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColorSchemes.grey,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          ImageIcon(AssetImage(iconPath)),
          Expanded(
            child: Center(
              child: AppText(content: title, style: AppTypography.text16w500),
            ),
          ),
        ],
      ),
    );
  }
}
