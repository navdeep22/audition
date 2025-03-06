import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/onboarding/presentation/pages/eula_compliance.dart';
import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var isEulaAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.onBoardingBackgroundImage))),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  30.verticalSpace,
                  AppText(
                      title: AppString.createAccount,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.headerTextStyle()),
                  10.verticalSpace,
                  AppText(
                      title: AppString.createProfile,
                      textAlign: TextAlign.center,
                      style: CustomTextStyle.subTitleTextStyle()),
                  const Spacer(),
                  // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //   IconButton(
                  //       onPressed: () {},
                  //       icon: const Icon(
                  //         Icons.check_box_outline_blank_rounded,
                  //         color: Colors.white,
                  //       )),
                  //   AppText(
                  //       title: AppString.haveReferCode,
                  //       textAlign: TextAlign.center,
                  //       style: CustomTextStyle.subTitleTextStyle()),
                  // ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    IconButton(
                        onPressed: () {
                          isEulaAccepted = !isEulaAccepted;
                          setState(() {});
                        },
                        icon: isEulaAccepted
                            ? const Icon(
                                Icons.check_box,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.check_box_outline_blank_rounded,
                                color: Colors.white,
                              )),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          isEulaAccepted = !isEulaAccepted;
                          AppFunctions.openBottomSheet(
                              context, EulaComplianceScreen());
                          setState(() {});
                        },
                        child: AppText(
                            title: AppString.acceptedEula,
                            textAlign: TextAlign.center,
                            style: CustomTextStyle.subTitleTextStyle()),
                      ),
                    ),
                  ]),
                  20.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      if (!isEulaAccepted) {
                        appToast(
                            msg:
                                "Please accept the End User License Agreement (EULA)");
                        return;
                      }
                      AppNavigator.navigateToLoginScreen(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        child: Card(
                          child: Row(
                            children: [
                              20.horizontalSpace,
                              const Icon(Icons.phone_in_talk_rounded),
                              20.horizontalSpace,
                              const Text(AppString.continueWithPhoneNo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
