import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/create_account/cubit/create_account_cubit.dart';
import 'package:fashion_shop/screens/create_account/cubit/create_account_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_text_field.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:fashion_shop/shared/common_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CreateAccountCubit(), child: const CreateAccountView());
  }
}

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAccountCubit, CreateAccountState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorSchemes.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18)),
                    SizedBox(height: 10.h),
                    AppText(content: 'Create Account'),
                    SizedBox(height: 20.h),
                    AppTextField(hinText: 'Firstname', controller: firstNameController),
                    SizedBox(height: 20.h),
                    AppTextField(hinText: 'Lastname', controller: lastNameController),
                    SizedBox(height: 20.h),
                    AppTextField(hinText: 'Email Address', controller: emailController),
                    SizedBox(height: 20.h),
                    AppTextField(hinText: 'Password', controller: passwordController),
                    SizedBox(height: 30.h),
                    GestureDetector(
                      onTap: () {
                        context.read<CreateAccountCubit>().createAccount(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text.trim(),
                        );
                      },
                      child: Container(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 17.h),
                        width: 390.w - 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColorSchemes.purple),
                        child: Center(
                          child: AppText(content: 'Continue', style: AppTypography.text16w500),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        AppText(content: 'Forgot Password ?', style: AppTypography.text12w450),
                        SizedBox(width: 6.w),
                        TextButton(
                          onPressed: () {},
                          child: Text('Reset', style: AppTypography.text12w450),
                        ),
                      ],
                    ),
                  ],
                ),
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
              onTap: () => context.read<CreateAccountCubit>().onClearErrorMessage(),
            );
          } else if (state.isSuccess) {
            context.go(RouteName.signIn);
          }
        }
      },
    );
  }
}
