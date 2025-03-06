import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF480004);
  static const appBackgroundColor = Color(0xFF900201);
  static const appTextColor = Color(0xFFFFFFFF);
  static const appGreyColor = Colors.grey;
  static const appGreenColor = Colors.green;
  static const appDisableColor = Colors.grey;
  static const splashBackgroundColor = Color.fromARGB(255, 60, 9, 12);
  // static const backgroundGradient = [
  //   Color.fromARGB(255, 200, 102, 81),
  //   Color.fromARGB(255, 232, 64, 125),
  // ];
  static const backgroundGradient = [
    Color(0xFFE21C34),
    Color(0xFF500B28),
  ];
  static var selectedGradient = [
    const Color(0xFF480004).withRed(110),
    const Color(0xFF900201),
    const Color(0xFF900201),
    const Color(0xFF480004).withRed(110)
  ];
}
