import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerStyle {
  static BoxDecoration cornerRadiusWithColor(
      double radius, Color? backgroundColor) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius), color: backgroundColor);
  }

  static BoxDecoration appGradientViewContainer(double radius) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(colors: AppColors.backgroundGradient));
  }
}
