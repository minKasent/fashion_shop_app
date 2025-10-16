import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/models/card_model.dart';
import 'package:fashion_shop/screens/payment/cubit/payment_cubit.dart';
import 'package:fashion_shop/screens/payment/cubit/payment_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_text_field.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<PaymentCubit>(),
      child: const _AddCardScreenView(),
    );
  }
}

class _AddCardScreenView extends StatefulWidget {
  const _AddCardScreenView();

  @override
  State<_AddCardScreenView> createState() => _AddCardScreenViewState();
}

class _AddCardScreenViewState extends State<_AddCardScreenView> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardholderNameController =
      TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  bool isEditMode = false;
  String? cardId;

  @override
  void initState() {
    super.initState();
    // Check if we're in edit mode
    final CardModel? selectedCard = context
        .read<PaymentCubit>()
        .state
        .selectedCard;
    if (selectedCard != null) {
      isEditMode = true;
      cardId = selectedCard.id;
      cardNumberController.text = selectedCard.cardNumber;
      cardholderNameController.text = selectedCard.cardholderName;
      expiryDateController.text = selectedCard.expiryDate;
      cvvController.text = selectedCard.cvv;
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    cardholderNameController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

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
          content: isEditMode ? "Edit Card" : "Add Card",
          style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state.apiErrorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.apiErrorMessage),
                backgroundColor: Colors.red,
              ),
            );
            context.read<PaymentCubit>().clearErrorMessage();
          } else if (state.isSuccess && !state.isLoading) {
            // Navigate back after successful add/update
            context.pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        AppTextField(
                          hinText: 'Card Number',
                          controller: cardNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                            _CardNumberInputFormatter(),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                hinText: 'CCV',
                                controller: cvvController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: AppTextField(
                                hinText: 'Exp',
                                controller: expiryDateController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                  _ExpiryDateInputFormatter(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        AppTextField(
                          hinText: 'Cardholder Name',
                          controller: cardholderNameController,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: state.isLoading ? null : executeSaveCard,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: state.isLoading
                            ? AppColorSchemes.darkGrey
                            : AppColorSchemes.purple,
                      ),
                      child: Center(
                        child: state.isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : AppText(
                                content: "Save",
                                style: AppTypography.text16w500.copyWith(
                                  color: AppColorSchemes.white,
                                ),
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

  void executeSaveCard() {
    final String cardNumber = cardNumberController.text
        .replaceAll(' ', '')
        .trim();
    final String cardholderName = cardholderNameController.text.trim();
    final String expiryDate = expiryDateController.text.trim();
    final String cvv = cvvController.text.trim();

    if (cardNumber.isEmpty ||
        cardholderName.isEmpty ||
        expiryDate.isEmpty ||
        cvv.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (cardNumber.length != 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card number must be 16 digits'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (cvv.length != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CVV must be 3 digits'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!expiryDate.contains('/') || expiryDate.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid expiry date format (MM/YY)'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String cardType = determineCardType(cardNumber);

    if (isEditMode && cardId != null) {
      context.read<PaymentCubit>().updateCard(
        cardId: cardId!,
        cardNumber: cardNumber,
        cardholderName: cardholderName,
        expiryDate: expiryDate,
        cvv: cvv,
        cardType: cardType,
      );
    } else {
      context.read<PaymentCubit>().addCard(
        cardNumber: cardNumber,
        cardholderName: cardholderName,
        expiryDate: expiryDate,
        cvv: cvv,
        cardType: cardType,
      );
    }
  }

  String determineCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return 'Visa';
    } else if (cardNumber.startsWith('5')) {
      return 'Mastercard';
    } else if (cardNumber.startsWith('3')) {
      return 'Amex';
    }
    return 'Unknown';
  }
}

// Formatter for card number (adds space every 4 digits)
class _CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text.replaceAll(' ', '');
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Formatter for expiry date (adds / after 2 digits)
class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String text = newValue.text.replaceAll('/', '');
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
