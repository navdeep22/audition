import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/parent_widget.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/profile/presentation/widget/profile_side_view.dart';
import 'package:audition/features/profile/presentation/widget/profile_upper_widget.dart';
import 'package:audition/features/profile/presentation/widget/profile_videos.dart';
import 'package:audition/resources/app_constants/app_colors.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  UserData? user;
  bool showSideView = false;
  Future<List<VideoResponse>?>? otherUserVideoList;
  ProfileServices profileServices = ProfileServices();

  @override
  void initState() {
    otherUserVideoList =
        profileServices.fetchUserVideos(user?.id ?? "", context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user = UserSingleton().userData;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              showSideView = false;
            });
          },
          child: ParentWidget(
              paddingOptional: true,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(user?.auditionId ?? "",
                              style: CustomTextStyle.descWithBolTextStyle()),
                          10.horizontalSpace,
                          const Icon(Icons.movie_creation_outlined,
                              color: Colors.white, size: 20)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () =>
                                  AppNavigator.navigateToChatScreen(context),
                              child: const Icon(Icons.message_outlined,
                                  color: Colors.white, size: 24)),
                          10.horizontalSpace,
                          GestureDetector(
                              onTap: () =>
                                  AppNavigator.navigateToBlockedUsersScreen(
                                      context),
                              child: const Icon(Icons.person_off_rounded,
                                  color: Colors.white, size: 24)),
                          if (showContest) ...[
                            10.horizontalSpace,
                            GestureDetector(
                              onTap: () =>
                                  AppNavigator.navigateToWalletScreen(context),
                              child: const Icon(Icons.currency_rupee_sharp,
                                  color: Colors.white, size: 24),
                            )
                          ],
                          10.horizontalSpace,
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  showSideView = true;
                                });
                              },
                              child: const Icon(Icons.menu,
                                  color: Colors.white, size: 24)),
                        ],
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Divider(
                      color: AppColors.appGreyColor.withOpacity(0.4),
                      height: 1,
                      thickness: 1),
                  15.verticalSpace,
                  ProfileUpperWidget(userData: user ?? UserData()),
                  15.verticalSpace,
                  AppButton(
                      title: AppString.editProfile,
                      isDisable: false,
                      onTap: () {
                        AppNavigator.navigateToEditProfileScreen(context);
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
              )),
        ),
        if (showSideView) const ProfileSideView()
      ],
    );
  }
}
