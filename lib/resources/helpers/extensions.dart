import 'package:flutter/material.dart';

extension SpaceWidthExtension on int {
  Widget get horizontalSpace => SizedBox(width: toDouble());
}

extension SpaceHeightExtension on int {
  Widget get verticalSpace => SizedBox(height: toDouble());
}

extension CapitalizeFirstLetter on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
