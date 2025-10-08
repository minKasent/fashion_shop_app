import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/setting/cubit/setting_cubit.dart';
import 'package:fashion_shop/screens/setting/cubit/setting_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SettingCubit>()..loadUserInfo(),
      child: const _SettingScreenView(),
    );
  }
}

class _SettingScreenView extends StatelessWidget {
  const _SettingScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.white,
      body: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state.apiErrorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.apiErrorMessage)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final userInfo = state.userInfo;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        content: userInfo != null
                            ? "${userInfo.firstName} ${userInfo.lastName}"
                            : "No name",
                        style: AppTypography.text16w500.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                              content: userInfo?.email ?? "No email",
                              style: AppTypography.text16w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              /// TODO: Implement edit profile
                            },
                            child: AppText(
                              content: "Edit",
                              style: AppTypography.text16w500.copyWith(
                                color: AppColorSchemes.purple,
                              ),
                            ),
                          ),
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
                  child: GestureDetector(
                    onTap: () async {
                      await context.read<SettingCubit>().signOut();
                      if (context.mounted) {
                        context.go(RouteName.signIn);
                      }
                    },
                    child: AppText(
                      content: "Sign Out",
                      style: AppTypography.text16w500.copyWith(
                        color: AppColorSchemes.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
