import 'package:fashion_shop/shared/app_typography.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String content;
  final TextStyle? style;
  final TextAlign? textAlign;
  const AppText({super.key, required this.content, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: style ?? AppTypography.text16w600, textAlign: textAlign ?? TextAlign.center, overflow: TextOverflow.ellipsis);
  }
}
