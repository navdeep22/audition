import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final String title;
  final Widget child;
  const BottomSheetContainer(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.backgroundGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Column(children: [
          Text(title, style: CustomTextStyle.appTextSize()),
          20.verticalSpace,
          Expanded(child: child)
        ]));
  }
}
