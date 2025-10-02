import 'package:fashion_shop/shared/app_color_schemes.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hinText;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const AppTextField({super.key, this.onChanged, required this.hinText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: TextStyle(color: AppColorSchemes.darkGrey, fontSize: 16),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        filled: true,
        fillColor: AppColorSchemes.grey,
      ),
    );
  }
}
