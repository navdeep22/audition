import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppPhoneTextfield extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  const AppPhoneTextfield({super.key, this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: CustomTextStyle.appTextSize(),
        controller: controller,
        maxLength: 10,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          counter: const SizedBox.shrink(),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColors.appGreyColor,
          ),
        ));
  }
}
