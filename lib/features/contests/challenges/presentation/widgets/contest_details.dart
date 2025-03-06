import 'dart:io';

import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/join_contest_pop_up.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContestDetails extends StatelessWidget {
  final bool showTopBanner;
  final ChallengesModel challengesModel;
  static const platform = MethodChannel('com.camerakit.flutter.sample.simple');
  const ContestDetails(
      {super.key, required this.showTopBanner, required this.challengesModel});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            showTopBanner ? 20.verticalSpace : 30.verticalSpace,
            if (showTopBanner)
              Expanded(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CacheImages(
                        imagePath: AppFunctions.createImageLink(
                            challengesModel.file ?? ""))),
              ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppString.maxUsers,
                              style: TextStyle(
                                  color: AppColors.appBackgroundColor,
                                  fontSize: 11),
                            ),
                            Text(
                              challengesModel.maximumUser.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                      Text(challengesModel.contestName ?? "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              AppString.userJoined,
                              style: TextStyle(
                                  color: AppColors.appBackgroundColor,
                                  fontSize: 11),
                            ),
                            Text(
                              challengesModel.joinedusers.toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    ],
                  ),
                  10.verticalSpace,
                  Divider(
                    color: AppColors.appGreyColor.shade300,
                    height: 1,
                    thickness: 1,
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.trophy,
                            color: Colors.black,
                            size: 17,
                          ),
                          8.horizontalSpace,
                          Text(
                              "${AppString.winners}: ${challengesModel.totalWinners}",
                              style: const TextStyle(
                                  color: AppColors.appGreenColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700))
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColors.appBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        width: 80,
                        height: 30,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.trophy,
                                color: AppColors.appTextColor,
                                size: 16,
                              ),
                              8.horizontalSpace,
                              Text(
                                  "${AppString.ruppeSymbol}${challengesModel.winAmount}",
                                  style: const TextStyle(
                                      color: AppColors.appTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ),
                      if ((challengesModel.bonusPercentage ?? 0) > 0)
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.black,
                              size: 17,
                            ),
                            5.horizontalSpace,
                            Text(
                                "${AppString.bonus}: ${challengesModel.bonusPercentage}%",
                                style: const TextStyle(
                                    color: AppColors.appBackgroundColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700))
                          ],
                        ),
                    ],
                  ),
                  5.verticalSpace
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 13, 8, 20),
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 40),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: AppColors.primaryColor.withOpacity(0.5)),
                      color: AppColors.primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              AppString.starts,
                              style: TextStyle(
                                  color: AppColors.appBackgroundColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              AppFunctions.dateConverter(
                                  challengesModel.startDate ?? DateTime.now()),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                      Row(children: [
                        const Text(
                          AppString.ends,
                          style: TextStyle(
                              color: AppColors.appBackgroundColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          AppFunctions.dateConverter(
                              challengesModel.endDate ?? DateTime.now()),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500),
                        )
                      ]),
                    ],
                  ),
                ),
                if (challengesModel.status == "notstarted" &&
                    challengesModel.finalStatus == "pending")
                  GestureDetector(
                    onTap: () {
                      if (challengesModel.status == "notstarted" &&
                          challengesModel.finalStatus == "pending") {
                        if (LoginSingleton().isGuestUser) {
                          AppNavigator.navigateToOnboardingScreen(context);
                        } else {
                          AppFunctions.showJoinContestDialogueBox(
                              context,
                              JoinContestPopUp(
                                challengesModel: challengesModel,
                                onJoinChallenge: (getUsableBalanceResponse) {
                                  Navigator.pop(context);
                                  if (double.parse(
                                          getUsableBalanceResponse.entryfee ??
                                              "0") >
                                      double.parse(getUsableBalanceResponse
                                              .usablebalance ??
                                          "0")) {
                                    AppNavigator.navigateToAddCashScreen(
                                        UserSingleton().userData ?? UserData(),
                                        context);
                                  } else {
                                    _openCameraKitLenses(context);
                                  }
                                },
                              ));
                        }
                      }
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 33),
                        decoration: const BoxDecoration(
                            color: AppColors.appGreenColor,
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        width: 80,
                        height: 43,
                        child: Center(
                          child: Column(
                            children: [
                              const Text(
                                AppString.entryFee,
                                style: TextStyle(
                                    color: AppColors.appTextColor,
                                    fontSize: 13),
                              ),
                              Text(
                                  "${AppString.ruppeSymbol}${challengesModel.entryfee.toString()}",
                                  style: const TextStyle(
                                      color: AppColors.appTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _openCameraKitLenses(BuildContext context) async {
    final result = await platform.invokeMethod('openCameraKitLenses');
    final String path = result['path'] as String;
    final String mimeType = result['mime_type'] as String;
    if (mimeType != 'video') {
      return;
    }
    // ignore: use_build_context_synchronously
    AppNavigator.navigateToViewRecordedVideo(
        File(path), true, challengesModel.id ?? "", context);
  }
}
