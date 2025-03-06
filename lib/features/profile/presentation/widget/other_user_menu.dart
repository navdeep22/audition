import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class OtherUserMenuItem extends StatelessWidget {
  final Function() reportUser;
  final Function() blockUser;
  const OtherUserMenuItem(
      {super.key, required this.reportUser, required this.blockUser});

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
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        15.verticalSpace,
        AppButton(title: AppString.report, isDisable: false, onTap: reportUser),
        AppButton(title: AppString.block, isDisable: false, onTap: blockUser),
        15.verticalSpace
      ]),
    );
  }
}
