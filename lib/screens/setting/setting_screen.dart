import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/models/user_model.dart';
import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/setting/cubit/setting_cubit.dart';
import 'package:fashion_shop/screens/setting/cubit/setting_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_text_field.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<SettingCubit>()..loadUserInfo(), child: const _SettingScreenView());
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.apiErrorMessage)));
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
                Center(child: CircleAvatar(radius: 50, backgroundImage: AssetImage(Assets.images.logoImg.path))),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(color: AppColorSchemes.grey, borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        content: userInfo != null ? "${userInfo.firstName} ${userInfo.lastName}" : "No name",
                        style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 7.h),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(content: userInfo?.email ?? "No email", style: AppTypography.text16w500),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showEditProfileBottomSheet(context, userInfo);
                            },
                            child: AppText(
                              content: "Edit",
                              style: AppTypography.text16w500.copyWith(color: AppColorSchemes.purple),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7.h),
                      AppText(content: "0909090909", style: AppTypography.text16w500),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                _buildAddressWidget(
                  title: 'Address',
                  onTap: () {
                    context.push(RouteName.address);
                  },
                ),
                SizedBox(height: 10.h),
                _buildAddressWidget(title: 'Payment Method'),
                SizedBox(height: 10.h),
                _buildAddressWidget(title: 'Shipping Address'),
                SizedBox(height: 10.h),
                _buildAddressWidget(title: 'Billing Address'),
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
                      style: AppTypography.text16w500.copyWith(color: AppColorSchemes.red),
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

  void _showEditProfileBottomSheet(BuildContext context, UserModel? userInfo) {
    final TextEditingController firstNameController = TextEditingController(text: userInfo?.firstName ?? '');
    final TextEditingController lastNameController = TextEditingController(text: userInfo?.lastName ?? '');

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColorSchemes.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext bottomSheetContext) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      content: "Edit Profile",
                      style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(bottomSheetContext),
                      child: Icon(Icons.close, size: 24.sp, color: AppColorSchemes.black),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                AppText(content: "First Name", style: AppTypography.text12w450),
                SizedBox(height: 8.h),
                AppTextField(hinText: 'Enter first name', controller: firstNameController),
                SizedBox(height: 16.h),
                AppText(content: "Last Name", style: AppTypography.text12w450),
                SizedBox(height: 8.h),
                AppTextField(hinText: 'Enter last name', controller: lastNameController),
                SizedBox(height: 30.h),
                SizedBox(
                  width: double.infinity,
                  child: BlocConsumer<SettingCubit, SettingState>(
                    bloc: getIt<SettingCubit>(),
                    listener: (context, state) {
                      if (state.apiErrorMessage.isEmpty && !state.isLoading) {
                        Navigator.pop(bottomSheetContext);
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Profile updated successfully'), backgroundColor: Colors.green));
                      }
                    },
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: state.isLoading
                            ? null
                            : () {
                                final firstName = firstNameController.text.trim();
                                final lastName = lastNameController.text.trim();

                                if (firstName.isEmpty || lastName.isEmpty) {
                                  ScaffoldMessenger.of(
                                    bottomSheetContext,
                                  ).showSnackBar(const SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.red));
                                  return;
                                }

                                getIt<SettingCubit>().updateUserInfo(firstName: firstName, lastName: lastName);
                              },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: state.isLoading ? AppColorSchemes.darkGrey : AppColorSchemes.purple,
                          ),
                          child: Center(
                            child: state.isLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                                  )
                                : AppText(
                                    content: "Update Profile",
                                    style: AppTypography.text16w500.copyWith(color: AppColorSchemes.white),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector _buildAddressWidget({VoidCallback? onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(color: AppColorSchemes.grey, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(content: title, style: AppTypography.text16w500),
            Icon(Icons.arrow_forward_ios, size: 20.sp, color: AppColorSchemes.purple),
          ],
        ),
      ),
    );
  }
}
