import 'dart:async';

import 'package:audition/core/network/repository/api_services/api_service.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

var showContest = false;

class OnboardingServices {
  ApiService apiService = ApiService();
  Future<void> generateGuestToken(BuildContext context) async {
    apiService.generateGuestToken(context).then((value) {
      if (value) {
        Timer(const Duration(seconds: 3), () {
          AppNavigator.navigateToLandingScreen(context);
        });
      }
    });
  }

  Future<bool> sendOTP(String mobile, BuildContext context) async {
    return await apiService.sendOTP(mobile, context);
  }

  Future<void> verifyOTP(
      String mobile, String otp, BuildContext context) async {
    apiService.verifyOTP(mobile, otp, context).then((onValue) {
      if (onValue) {
        AppNavigator.navigateToLandingScreen(context);
      }
    });
  }

  Future<void> checkContest(BuildContext context) async {
    apiService.checkContest(context).then((onValue) {
      if (onValue) {
        //  AppNavigator.navigateToLandingScreen(context);
      }
    });
  }
}
