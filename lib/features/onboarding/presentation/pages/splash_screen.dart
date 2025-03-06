import 'dart:async';

import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkforLogin();
    OnboardingServices().checkContest(context);
  }

  checkforLogin() async {
    var loginToken =
        await AppStorage.getStorageValueString(AppStorageKeys.loginToken);
    if (loginToken != null) {
      var isGuest =
          await AppStorage.getStorageValueBool(AppStorageKeys.isGuest);
      LoginSingleton().updateGuestUser(isGuest ?? true);
      if ((isGuest ?? true) == false) {
        ProfileServices().getUserProfile(context);
      }
      Timer(const Duration(seconds: 3), () {
        AppNavigator.navigateToLandingScreen(context);
      });
    } else {
      OnboardingServices().generateGuestToken(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(color: AppColors.splashBackgroundColor),
        child: SafeArea(
            child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Image.asset(
            AppImages.splashLogo,
            fit: BoxFit.fill,
          )),
        )));
  }
}
