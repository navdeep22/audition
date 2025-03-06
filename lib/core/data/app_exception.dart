import 'dart:convert';

import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppException {
  static Future<void> manageException(
      http.Response response, BuildContext context) async {
    if (response.statusCode == 401 || response.statusCode == 440) {
      AppNavigator.navigateToLoginScreen(context);
      AppStorage.clear();
    } else if (response.statusCode == 400) {
      final json = jsonDecode(response.body);
      appToast(msg: json["message"]);
    } else if (response.statusCode == 500) {
      appToast(msg: AppString.internalServerError);
    } else {
      appToast(msg: AppString.error);
    }
  }
}
