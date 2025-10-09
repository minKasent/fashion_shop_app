import 'package:fashion_shop/di/injector.dart';
import 'package:fashion_shop/models/address_model.dart';
import 'package:fashion_shop/screens/address/cubit/address_cubit.dart';
import 'package:fashion_shop/screens/address/cubit/address_state.dart';
import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:fashion_shop/shared/app_text.dart';
import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<AddressCubit>()..loadAddresses(), child: const _AddressScreenView());
  }
}

class _AddressScreenView extends StatelessWidget {
  const _AddressScreenView();

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
          content: "Address",
          style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state.apiErrorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.apiErrorMessage), backgroundColor: Colors.red));
            context.read<AddressCubit>().clearErrorMessage();
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.addresses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Expanded(
                  child: state.addresses.isEmpty
                      ? Center(
                          child: AppText(
                            content: "No addresses found",
                            style: AppTypography.text16w500.copyWith(color: AppColorSchemes.darkGrey),
                          ),
                        )
                      : ListView.separated(
                          itemCount: state.addresses.length,
                          separatorBuilder: (context, index) => SizedBox(height: 12.h),
                          itemBuilder: (context, index) {
                            final AddressModel address = state.addresses[index];
                            return _buildAddressItem(context, address);
                          },
                        ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      context.read<AddressCubit>().setSelectedAddress(null);
                      context.push('/add-address');
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColorSchemes.purple),
                      child: Center(
                        child: AppText(
                          content: "Add Address",
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

  Widget _buildAddressItem(BuildContext context, AddressModel address) {
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
                  content: address.streetAddress,
                  style: AppTypography.text16w500.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                AppText(
                  content: "${address.city}, ${address.state} ${address.zipCode}",
                  style: AppTypography.text12w450.copyWith(color: AppColorSchemes.darkGrey),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<AddressCubit>().setSelectedAddress(address);
              context.push('/add-address');
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
