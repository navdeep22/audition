import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileUpperWidget extends StatelessWidget {
  final UserData userData;
  const ProfileUpperWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white),
                  borderRadius: BorderRadius.circular(40)),
              child: (userData.image != "")
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: CacheImages(
                        imagePath: userData.image ?? "",
                      ),
                    )
                  : const Icon(
                      FontAwesomeIcons.solidCircleUser,
                      size: 70,
                      color: Colors.white,
                    ),
            ),
            5.verticalSpace,
            SizedBox(
              width: 100,
              child: Text(userData.bio ?? "",
                  maxLines: 3, style: CustomTextStyle.descWithBolTextStyle()),
            ),
          ],
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Text(userData.auditionId ?? "",
                        style: CustomTextStyle.descWithBolTextStyle()),
                    10.horizontalSpace,
                    const Icon(Icons.copy, color: Colors.white, size: 20)
                  ],
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (LoginSingleton().isGuestUser) {
                        appToast(msg: AppString.guestUserError);
                        return;
                      }
                      AppNavigator.navigateToFollowersFollowingScreen(
                          userData, context);
                    },
                    child: Column(
                      children: [
                        Text("${userData.followersCount}",
                            style: CustomTextStyle.subTitleTextStyle()),
                        5.verticalSpace,
                        Text(AppString.followers,
                            style: CustomTextStyle.descWithBolTextStyle()),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        if (LoginSingleton().isGuestUser) {
                          appToast(msg: AppString.guestUserError);
                          return;
                        }
                        AppNavigator.navigateToFollowersFollowingScreen(
                            userData, context);
                      },
                      child: Column(
                        children: [
                          Text("${userData.followingCount}",
                              style: CustomTextStyle.subTitleTextStyle()),
                          5.verticalSpace,
                          Text(AppString.following,
                              style: CustomTextStyle.descWithBolTextStyle()),
                        ],
                      )),
                  Column(
                    children: [
                      Text("${userData.totalLike}",
                          style: CustomTextStyle.subTitleTextStyle()),
                      5.verticalSpace,
                      Text(AppString.likes,
                          style: CustomTextStyle.descWithBolTextStyle()),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
