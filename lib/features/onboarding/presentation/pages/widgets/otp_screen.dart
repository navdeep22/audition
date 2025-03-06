import 'package:audition/features/account_verification/domain/account_verification_services.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/app_text.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  final bool isEmailVerify;
  final String mobileNo;
  const OtpScreen(
      {super.key, required this.mobileNo, required this.isEmailVerify});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  OnboardingServices onboardingServices = OnboardingServices();
  bool enableBtn = false;
  String otp = '';
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 40, right: 40),
        decoration:
            ContainerStyle.cornerRadiusWithColor(7, AppColors.primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
                title: "Enter OTP", style: CustomTextStyle.subTitleTextStyle()),
            10.verticalSpace,
            OtpTextField(
              textStyle: CustomTextStyle.headerTextStyle(),
              onCodeChanged: (value) {
                enableBtn = false;
                setState(() {});
              },
              onSubmit: (value) {
                otp = value;
                if (value.length != 4) {
                  enableBtn = false;
                } else {
                  enableBtn = true;
                }
                setState(() {});
              },
              showFieldAsBox: true,
              fieldWidth: 50,
              fieldHeight: 50,
            ),
            10.verticalSpace,
            AppButton(
              title: widget.isEmailVerify ? "Verify Email" : "Login with OTP",
              isDisable: !enableBtn,
              onTap: () {
                if (enableBtn) {
                  if (widget.isEmailVerify) {
                    AccountVerificationServices()
                        .verifyOTP(widget.mobileNo, otp, context);
                    Navigator.pop(context);
                  } else {
                    onboardingServices.verifyOTP(widget.mobileNo, otp, context);
                  }
                }
              },
            )
          ],
        ));
  }
}
