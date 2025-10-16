import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/models/card_model.dart';
import 'package:fashion_shop/router/route_name.dart';
import 'package:fashion_shop/screens/payment/cubit/payment_cubit.dart';
import 'package:fashion_shop/screens/payment/cubit/payment_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: getIt<PaymentCubit>()..loadCards(), child: const _PaymentScreenView());
  }
}

class _PaymentScreenView extends StatelessWidget {
  const _PaymentScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorSchemes.white,
      appBar: AppBar(
        backgroundColor: AppColorSchemes.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back_ios, color: AppColorSchemes.black),
        ),
        title: AppText(
          content: "Payment",
          style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.apiErrorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.apiErrorMessage), backgroundColor: Colors.red));
            context.read<PaymentCubit>().clearErrorMessage();
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.cards.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Expanded(
                  child: state.cards.isEmpty
                      ? Center(
                          child: AppText(
                            content: "Chưa có Card nào",
                            style: AppTypography.text16w500.copyWith(color: AppColorSchemes.darkGrey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: state.cards.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final CardModel card = state.cards[index];
                            return _buildCardItem(context, card);
                          },
                        ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      context.read<PaymentCubit>().setSelectedCard(null);
                      context.push(RouteName.addCard);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColorSchemes.purple),
                      child: Center(
                        child: AppText(
                          content: "Add Card",
                          style: AppTypography.text16w500.copyWith(color: AppColorSchemes.white),
                        ),
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

  Widget _buildCardItem(BuildContext context, CardModel card) {
    final String maskedCardNumber = '**** ${card.cardNumber.substring(card.cardNumber.length - 4)}';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: AppColorSchemes.grey, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  content: maskedCardNumber,
                  style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                AppText(
                  content: card.cardholderName,
                  style: AppTypography.text12w450.copyWith(color: AppColorSchemes.darkGrey),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<PaymentCubit>().setSelectedCard(card);
              context.push(RouteName.addCard);
            },
            child: AppText(
              content: "Edit",
              style: AppTypography.text12w450.copyWith(color: AppColorSchemes.purple),
            ),
          ),
        ],
      ),
    );
  }
}
