import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

appToast({String? msg}) {
  return Fluttertoast.showToast(
    msg: msg!,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.appTextColor,
    textColor: Colors.black,
    fontSize: 16.0,
  );
}
