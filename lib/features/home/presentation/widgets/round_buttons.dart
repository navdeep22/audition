import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class RoundButtons extends StatelessWidget {
  final bool isSelected;
  final String title;
  final Function(String) onTap;
  const RoundButtons(
      {super.key,
      required this.isSelected,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap(title);
        },
        child: Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.appBackgroundColor,
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 7),
          child: Text(title, style: CustomTextStyle.appButtonTextStyle()),
        ));
  }
}
