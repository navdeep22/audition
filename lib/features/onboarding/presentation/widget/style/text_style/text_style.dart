import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle headerTextStyle() {
    return const TextStyle(
        color: AppColors.appTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w500);
  }

  static TextStyle subTitleTextStyle() {
    return const TextStyle(color: AppColors.appTextColor, fontSize: 15);
  }

  static TextStyle appButtonTextStyle() {
    return const TextStyle(color: AppColors.appTextColor, fontSize: 13);
  }

  static TextStyle subTitleWithBoldTextStyle() {
    return const TextStyle(
        color: AppColors.appTextColor,
        fontSize: 15,
        fontWeight: FontWeight.bold);
  }

  static TextStyle appTextSize() {
    return const TextStyle(color: AppColors.appTextColor, fontSize: 18);
  }

  static TextStyle descTextStyle() {
    return const TextStyle(color: AppColors.appTextColor, fontSize: 12);
  }

  static TextStyle smallTextStyle() {
    return const TextStyle(color: AppColors.appTextColor, fontSize: 11);
  }

  static TextStyle descWithBolTextStyle() {
    return const TextStyle(
        color: AppColors.appTextColor,
        fontSize: 12,
        fontWeight: FontWeight.bold);
  }
}
