import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:audition/features/onboarding/presentation/pages/widgets/otp_screen.dart';
import 'package:audition/features/onboarding/presentation/widget/app_phone_textfield.dart';
import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/onboarding/presentation/widget/parent_widget.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_images.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber = TextEditingController();
  OnboardingServices onboardingServices = OnboardingServices();
  bool showLogin = false;
  @override
  Widget build(BuildContext context) {
    return ParentWidget(
        paddingOptional: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  OnboardingServices().generateGuestToken(context);
                },
                child: const Icon(Icons.close,
                    size: 33, color: AppColors.appTextColor)),
            8.verticalSpace,
            AppText(
                title: AppString.createAccountLogin,
                style: CustomTextStyle.headerTextStyle()),
            5.verticalSpace,
            AppText(
                title: AppString.willSendOtp,
                style: CustomTextStyle.descTextStyle()),
            20.verticalSpace,
            Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: ContainerStyle.cornerRadiusWithColor(
                        7, AppColors.primaryColor),
                    height: 42,
                    width: 100,
                    child: Row(children: [
                      5.horizontalSpace,
                      Image.asset(AppIcons.indianFlag, width: 25),
                      5.horizontalSpace,
                      AppText(
                          title: "+91", style: CustomTextStyle.appTextSize()),
                      const Icon(Icons.arrow_drop_down_outlined,
                          color: Colors.white)
                    ])),
                12.horizontalSpace,
                Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    decoration: ContainerStyle.cornerRadiusWithColor(
                        7, AppColors.primaryColor),
                    height: 42,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: AppPhoneTextfield(
                        controller: phoneNumber,
                        hintText: AppString.phoneNumberHint))
              ],
            ),
            20.verticalSpace,
            if (showLogin)
              OtpScreen(
                mobileNo: phoneNumber.text,
                isEmailVerify: false,
              ),
            const Spacer(),
            if (!showLogin)
              GestureDetector(
                onTap: () {
                  if (phoneNumber.text.isEmpty ||
                      phoneNumber.text.length < 10) {
                    appToast(msg: AppString.enterPhoneNumberValidation);
                    return;
                  }
                  onboardingServices
                      .sendOTP(phoneNumber.text, context)
                      .then((onValue) {
                    if (onValue) {
                      setState(() {
                        showLogin = !showLogin;
                      });
                    }
                  });
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.appTextColor,
                    ),
                    height: 60,
                    width: 60,
                    child: const Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              )
          ],
        ));
  }
}
