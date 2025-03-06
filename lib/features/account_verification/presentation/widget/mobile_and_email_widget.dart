import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/account_verification/domain/account_verification_services.dart';
import 'package:audition/features/account_verification/model/all_verify_response_model.dart';
import 'package:audition/features/onboarding/presentation/pages/widgets/otp_screen.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/app_textfield.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class MobileAndEmailWidget extends StatefulWidget {
  final AllVerifyModel? allVerifyModel;
  const MobileAndEmailWidget({super.key, required this.allVerifyModel});

  @override
  State<MobileAndEmailWidget> createState() => _MobileAndEmailWidgetState();
}

class _MobileAndEmailWidgetState extends State<MobileAndEmailWidget> {
  TextEditingController emailEditingController = TextEditingController();
  AccountVerificationServices accountVerificationServices =
      AccountVerificationServices();
  bool otpSent = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      15.verticalSpace,
      Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          decoration: ContainerStyle.appGradientViewContainer(10),
          child: Row(children: [
            const Icon(Icons.mobile_friendly, color: Colors.white, size: 28),
            10.horizontalSpace,
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(AppString.mobileVerified,
                  style: CustomTextStyle.subTitleTextStyle()),
              Text(widget.allVerifyModel?.mobile.toString() ?? "",
                  style: const TextStyle(color: Colors.yellow, fontSize: 17))
            ])
          ])),
      10.verticalSpace,
      if (widget.allVerifyModel?.emailVerify == 0 && otpSent)
        OtpScreen(
          mobileNo: emailEditingController.text,
          isEmailVerify: true,
        ),
      if (widget.allVerifyModel?.emailVerify == 0 && !otpSent)
        emailNotVerified(),
      if (widget.allVerifyModel?.emailVerify == 1) emailVerified()
    ]);
  }

  Widget emailNotVerified() {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: ContainerStyle.appGradientViewContainer(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(AppString.verifyYourEmail,
              style: CustomTextStyle.subTitleTextStyle()),
          10.verticalSpace,
          Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              decoration: ContainerStyle.cornerRadiusWithColor(
                  7, AppColors.primaryColor),
              height: 45,
              child: AppTextfield(
                  controller: emailEditingController,
                  hintText: AppString.emailAddress)),
          const Text(AppString.emailSendOTPDesc,
              style: TextStyle(color: Colors.yellow, fontSize: 12)),
          20.verticalSpace,
          AppButton(
              title: AppString.sendOTP,
              isDisable: false,
              onTap: () {
                FocusScope.of(context).unfocus();
                if (emailEditingController.text.isEmpty ||
                    !AppFunctions.isValidEmail(emailEditingController.text)) {
                  appToast(msg: AppString.enterEmailValidation);
                  return;
                }
                accountVerificationServices.verifyEmailAddress(
                    emailEditingController.text, context);
                setState(() {
                  otpSent = true;
                });
              })
        ]));
  }

  Widget emailVerified() {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: ContainerStyle.appGradientViewContainer(20),
        child: Row(children: [
          const Icon(Icons.email_outlined, color: Colors.white, size: 28),
          10.horizontalSpace,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(AppString.emailVerified,
                style: CustomTextStyle.subTitleTextStyle()),
            Text(widget.allVerifyModel?.email.toString() ?? "",
                style: const TextStyle(color: Colors.yellow, fontSize: 17))
          ])
        ]));
  }
}
