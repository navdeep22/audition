import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/presentation/widgets/legends/feed_report.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/profile/presentation/widget/other_user_menu.dart';
import 'package:audition/features/profile/presentation/widget/profile_upper_widget.dart';
import 'package:audition/features/profile/presentation/widget/profile_videos.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_functions.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/alerts/report_alert.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class OtherUserProfile extends StatefulWidget {
  final VideoResponse? videoResponse;
  const OtherUserProfile({super.key, this.videoResponse});

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  Future<UserData?>? otherUserData;
  Future<List<VideoResponse>?>? otherUserVideoList;
  ProfileServices profileServices = ProfileServices();
  HomeServices homeServices = HomeServices();
  bool showSideView = false;

  @override
  void initState() {
    otherUserVideoList = profileServices.fetchUserVideos(
        widget.videoResponse?.userId ?? "", context);
    otherUserData = profileServices.getOtherUserProfileDetailsById(
        widget.videoResponse?.userId ?? "", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: false,
        title: widget.videoResponse?.auditionId ?? "",
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
              onTap: () {
                AppFunctions.openDynamicBottomSheet(
                    context,
                    OtherUserMenuItem(reportUser: () {
                      reportUser(widget.videoResponse?.userId ?? "");
                    }, blockUser: () {
                      blockuser(widget.videoResponse?.userId ?? "");
                    }));
              },
              child: const Icon(Icons.menu, color: Colors.white)),
        ),
        child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              children: [
                FutureBuilder(
                    future: otherUserData,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const SizedBox.shrink();
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            var otherUserData = snapshot.data;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ProfileUpperWidget(
                                    userData: otherUserData ?? UserData()),
                                15.verticalSpace,
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppButton(
                                          title: (otherUserData?.followStatus ??
                                                  false)
                                              ? AppString.unfollow
                                              : AppString.follow,
                                          isDisable: false,
                                          onTap: () {
                                            followUser(
                                                widget.videoResponse?.userId ??
                                                    "",
                                                otherUserData?.followStatus ??
                                                    false);
                                          }),
                                    ),
                                    Expanded(
                                      child: AppButton(
                                          title: AppString.message,
                                          isDisable: false,
                                          onTap: () {}),
                                    )
                                  ],
                                )
                              ],
                            );
                          }
                      }
                    }),
                10.verticalSpace,
                Expanded(
                  child: FutureBuilder(
                      future: otherUserVideoList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const SizedBox.shrink();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              var videoList = snapshot.data;
                              return ProfileVideos(videos: videoList);
                            }
                        }
                      }),
                )
              ],
            )));
  }

  void reportUser(String userId) {
    if (LoginSingleton().isGuestUser) {
      appToast(msg: AppString.guestUserError);
      return;
    }
    AppFunctions.openBottomSheet(context,
        FeedReport(userId: userId, reportUser: true, videoResponse: null));
  }

  void blockuser(String userId) {
    if (LoginSingleton().isGuestUser) {
      appToast(msg: AppString.guestUserError);
      return;
    }
    AppFunctions.showDialogueBox(
      context,
      ReportAlert(
        title: AppString.block,
        subtitle: AppString.blockConfirmation,
        onTap: (status) {
          if (status) {
            profileServices.blockUnBlocktUser(userId, true, context);
            AppNavigator.navigateToLandingScreen(context);
          }
        },
      ),
    );
  }

  void followUser(String userId, bool status) async {
    if (LoginSingleton().isGuestUser) {
      appToast(msg: AppString.guestUserError);
      return;
    }
    var userStatus =
        await profileServices.followUnfollowUser(userId, !status, context);
    if (userStatus ?? false) {
      otherUserData = profileServices.getOtherUserProfileDetailsById(
          widget.videoResponse?.userId ?? "", context);

      setState(() {});
    }
  }

  void messageUser() {}
}
