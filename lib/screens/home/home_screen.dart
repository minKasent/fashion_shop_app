import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.white,
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(Assets.images.logoImg.path),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColorSchemes.grey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    content: "Dang Khoa",
                    style: AppTypography.text16w500.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 7.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        content: "dangkhoa123@gmail.com",
                        style: AppTypography.text16w500,
                      ),
                      GestureDetector(
                        onTap: () {
                          /// TODO: Implement edit profile
                        },
                        child: AppText(
                          content: "Edit",
                          style: AppTypography.text16w500.copyWith(color: AppColorSchemes.purple),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7.h),
                  AppText(
                    content: "0909090909",
                    style: AppTypography.text16w500,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            _buildAddressWidget(),
            SizedBox(height: 10.h),
            _buildAddressWidget(),
            SizedBox(height: 10.h),
            _buildAddressWidget(),
            SizedBox(height: 10.h),
            _buildAddressWidget(),
            SizedBox(height: 30.h),
            Center(
              child: AppText(
                content: "Sign Out",
                style: AppTypography.text16w500.copyWith(
                  color: AppColorSchemes.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildAddressWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColorSchemes.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(content: "Address", style: AppTypography.text16w500),
          Icon(
            Icons.arrow_forward_ios,
            size: 20.sp,
            color: AppColorSchemes.purple,
          ),
        ],
      ),
    );
  }
}
