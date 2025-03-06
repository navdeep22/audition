import 'package:audition/features/onboarding/presentation/widget/app_button.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/model/followers_following_response.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FollowUnfollowTile extends StatelessWidget {
  final List<FollowerList> userList;
  final bool fromBlockUsers;
  final Function(FollowerList) unfollowUser;
  const FollowUnfollowTile(
      {super.key,
      required this.userList,
      required this.fromBlockUsers,
      required this.unfollowUser});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          var user = userList[index];
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: ContainerStyle.appGradientViewContainer(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(40)),
                  child: (user.image != "")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: CacheImages(
                            imagePath: user.image ?? "",
                          ),
                        )
                      : const Icon(
                          FontAwesomeIcons.solidCircleUser,
                          size: 30,
                          color: Colors.white,
                        ),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name ?? "",
                        style: CustomTextStyle.descWithBolTextStyle()),
                    Text("${user.followersCount ?? "0"} ${AppString.followers}",
                        style: CustomTextStyle.smallTextStyle()),
                    Text(user.auditionId ?? "",
                        style: CustomTextStyle.descWithBolTextStyle()),
                  ],
                ),
                const Spacer(),
                fromBlockUsers
                    ? SizedBox(
                        height: 50,
                        width: 110,
                        child: AppButton(
                            title: AppString.unblock,
                            isDisable: false,
                            onTap: () {
                              unfollowUser(user);
                            }),
                      )
                    : SizedBox(
                        height: 50,
                        width: 110,
                        child: AppButton(
                            title: (user.followStatus ?? false)
                                ? AppString.unfollow
                                : AppString.follow,
                            isDisable: false,
                            onTap: () {
                              unfollowUser(user);
                            }),
                      )
              ],
            ),
          );
        });
  }
}
