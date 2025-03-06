import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/features/landing/presentation/widget/language_picker/language_picker.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/alerts/report_alert.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProfileSideView extends StatelessWidget {
  const ProfileSideView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                20.verticalSpace,
                const Text(AppString.profileSettings,
                    style: TextStyle(
                        color: AppColors.appBackgroundColor, fontSize: 16)),
                20.verticalSpace,
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppString.account,
                        style: TextStyle(
                            color: AppColors.appBackgroundColor, fontSize: 14)),
                  ),
                ),
                20.verticalSpace,
                // tiles(Icons.phone_android_sharp, AppString.accountVerification,
                //     () {
                //   AppNavigator.navigateToVerifyAccountScreen(context);
                // }),
                tiles(Icons.phone, AppString.changeLanguage, () {
                  AppFunctions.openBottomSheet(
                      context,
                      LanguagePicker(
                        onLanguageSelect: (newLanguage) {},
                      ));
                }),
                // tiles(Icons.lock_open_rounded, AppString.privacyPolicy, () {
                //   AppNavigator.navigateToAppWebViewScreen(
                //       AppString.privacyPolicy,
                //       "https://biggee.in/privacy-policy.html",
                //       context);
                // }),
                // tiles(Icons.info_outline, AppString.aboutUs, () {
                //   AppNavigator.navigateToAppWebViewScreen(AppString.aboutUs,
                //       "https://biggee.in/about-us.html", context);
                // }),
                // tiles(Icons.shield_outlined, AppString.termsCondition, () {
                //   AppNavigator.navigateToAppWebViewScreen(
                //       AppString.termsCondition,
                //       "https://biggee.in/tnc.html",
                //       context);
                // }),
                tiles(Icons.share, AppString.refer, () async {
                  await Share.share(
                      "Explore the world of short videos and turn your creativity into cash! Join our exciting contests, showcase your talent, and win amazing prizes. Download now and be a part of the Biggee");
                }),
                tiles(Icons.share, AppString.shareProfile, () async {
                  await Share.share(
                      'Hey! Follow my profile on biggee search ${UserSingleton().userData?.auditionId} or Click https://biggee.in/profile/${UserSingleton().userData?.auditionId} \n Download App from https://play.google.com/store/apps/details?id=com.img.audition ');
                }),
                // tiles(Icons.document_scanner_outlined, AppString.howToWin, () {
                //   AppNavigator.navigateToAppWebViewScreen(
                //       AppString.helpsupport, "https://biggee.in", context);
                // }),
                if (showContest)
                  tiles(Icons.wallet, AppString.wallet, () {
                    AppNavigator.navigateToWalletScreen(context);
                  }),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppString.helpsupport,
                        style: TextStyle(
                            color: AppColors.appBackgroundColor, fontSize: 14)),
                  ),
                ),
                20.verticalSpace,
                // tiles(Icons.info_outline, AppString.helpsupport, () {
                //   AppNavigator.navigateToAppWebViewScreen(AppString.helpsupport,
                //       "https://biggee.in/how-to-win.html", context);
                // }),
                tiles(Icons.logout_rounded, AppString.logout, () {
                  AppFunctions.logoutUser(context);
                }),
                tiles(Icons.delete_forever, AppString.delete, () {
                  AppFunctions.showDialogueBox(
                      context,
                      ReportAlert(
                        title: AppString.delete,
                        subtitle: AppString.deleteAccountConfirmation,
                        onTap: (status) {
                          if (status) {
                            AppFunctions.logoutUser(context);
                          } else {}

                          Navigator.pop(context);
                        },
                      ));
                }),
              ],
            )),
      ),
    );
  }

  Widget tiles(IconData icon, String title, Function ontap) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.only(bottom: 25),
        child: Row(children: [
          Icon(icon, color: AppColors.appBackgroundColor, size: 20),
          5.horizontalSpace,
          Text(title,
              style: const TextStyle(
                  color: AppColors.appBackgroundColor, fontSize: 14))
        ]),
      ),
    );
  }
}
