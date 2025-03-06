import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool? isEnabled;
  const AppTextfield(
      {super.key, this.hintText, required this.controller, this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
        style: CustomTextStyle.subTitleTextStyle(),
        controller: controller,
        enabled: isEnabled,
        maxLines: 5,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          counter: const SizedBox.shrink(),
          border: InputBorder.none,
          hintText: hintText,
          labelStyle: const TextStyle(fontSize: 12),
          hintStyle: const TextStyle(
            color: AppColors.appGreyColor,
          ),
        ));
  }
}
