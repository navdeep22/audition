import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/followers_following_response.dart';
import 'package:audition/features/profile/presentation/widget/follow_unfollow_tile.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  Future<List<FollowerList>?>? blockedUsers;
  ProfileServices profileServices = ProfileServices();
  @override
  void initState() {
    blockedUsers = profileServices.blockedUserList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
      paddingOptional: false,
      title: AppString.blockedUsers,
      child: FutureBuilder(
          future: blockedUsers,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const SizedBox.shrink();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var blockUserList = snapshot.data;

                  return blockUserList!.isEmpty
                      ? Center(
                          child: Text(AppString.noDataFound,
                              style: CustomTextStyle.subTitleTextStyle()))
                      : FollowUnfollowTile(
                          userList: blockUserList,
                          fromBlockUsers: true,
                          unfollowUser: (followerList) {
                            profileServices.blockUnBlocktUser(
                                followerList.id ?? "", false, context);
                            blockUserList.removeWhere(
                                (element) => element.id == followerList.id);
                            setState(() {});
                          },
                        );
                }
            }
          }),
    );
  }
}
