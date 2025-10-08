import 'package:fashion_shop/core/assets_gen/assets.gen.dart';
import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/sign_in/cubit/sign_in_cubit.dart';
import 'package:fashion_shop/screens/sign_in/cubit/sign_in_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_text_field.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:fashion_shop/shared/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => SignInCubit(), child: const SignInView());
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorSchemes.white,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h),
                  AppText(content: "Sign in"),
                  SizedBox(height: 20.h),
                  AppTextField(hinText: 'Email Address', controller: emailController),
                  SizedBox(height: 25.h),
                  AppTextField(hinText: 'Password', controller: passwordController),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 17.h),
                    width: 390.w - 40,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColorSchemes.purple),
                    child: GestureDetector(
                      onTap: () {
                        context.read<SignInCubit>().signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      },
                      child: AppText(content: "Continue", style: AppTypography.text16w500),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () => context.push(RouteName.createAccount),
                    child: AppText(content: "Don't have an account? Sign up", style: AppTypography.text12w450),
                  ),
                  SizedBox(height: 50.h),
                  _buildLoginWidget(iconPath: Assets.icons.apple.path, title: 'Continue With Apple'),
                  SizedBox(height: 20.h),
                  _buildLoginWidget(iconPath: Assets.icons.google.path, title: 'Continue With Google'),
                  SizedBox(height: 20.h),
                  _buildLoginWidget(iconPath: Assets.icons.facebook.path, title: 'Continue With Facebook'),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.isLoading) {
          CommonDialogs.showLoadingDialog(context);
        } else {
          CommonDialogs.hideLoadingDialog(context);
          if (state.apiErrorMessage.isNotEmpty) {
            CommonDialogs.showErrorDialog(
              context: context,
              title: 'Error',
              message: state.apiErrorMessage,
              onTap: () => context.read<SignInCubit>().onClearSignInErrorMessage(),
            );
          } else if (state.isSuccess) {
            context.go(RouteName.setting);
          }
        }
      },
    );
  }

  Container _buildLoginWidget({required String iconPath, required String title}) {
    return Container(
      padding: EdgeInsetsGeometry.symmetric(vertical: 17.h, horizontal: 20.w),
      decoration: BoxDecoration(color: AppColorSchemes.grey, borderRadius: BorderRadius.circular(100)),
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
