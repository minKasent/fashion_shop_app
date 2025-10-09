import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/models/address_model.dart';
import 'package:fashion_shop/screens/address/cubit/address_cubit.dart';
import 'package:fashion_shop/screens/address/cubit/address_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_text_field.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: getIt<AddressCubit>(), child: const _AddAddressScreenView());
  }
}

class _AddAddressScreenView extends StatefulWidget {
  const _AddAddressScreenView();

  @override
  State<_AddAddressScreenView> createState() => _AddAddressScreenViewState();
}

class _AddAddressScreenViewState extends State<_AddAddressScreenView> {
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  bool isEditMode = false;
  String? addressId;

  @override
  void initState() {
    super.initState();
    // Check if we're in edit mode
    final AddressModel? selectedAddress = context.read<AddressCubit>().state.selectedAddress;
    if (selectedAddress != null) {
      isEditMode = true;
      addressId = selectedAddress.id;
      streetAddressController.text = selectedAddress.streetAddress;
      cityController.text = selectedAddress.city;
      stateController.text = selectedAddress.state;
      zipCodeController.text = selectedAddress.zipCode;
    }
  }

  @override
  void dispose() {
    streetAddressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
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
          content: isEditMode ? "Edit Address" : "Add Address",
          style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state.apiErrorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.apiErrorMessage), backgroundColor: Colors.red));
            context.read<AddressCubit>().clearErrorMessage();
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
                        AppTextField(hinText: 'Street Address', controller: streetAddressController),
                        SizedBox(height: 20.h),
                        AppTextField(hinText: 'City', controller: cityController),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(hinText: 'State', controller: stateController),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: AppTextField(hinText: 'Zip Code', controller: zipCodeController),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: state.isLoading ? null : executeSaveAddress,
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
                                content: "Save",
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

  void executeSaveAddress() {
    final String streetAddress = streetAddressController.text.trim();
    final String city = cityController.text.trim();
    final String state = stateController.text.trim();
    final String zipCode = zipCodeController.text.trim();

    if (streetAddress.isEmpty || city.isEmpty || state.isEmpty || zipCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields'), backgroundColor: Colors.red));
      return;
    }

    if (isEditMode && addressId != null) {
      context.read<AddressCubit>().updateAddress(
        addressId: addressId!,
        streetAddress: streetAddress,
        city: city,
        stateValue: state,
        zipCode: zipCode,
      );
    } else {
      context.read<AddressCubit>().addAddress(streetAddress: streetAddress, city: city, stateValue: state, zipCode: zipCode);
    }
  }
}
