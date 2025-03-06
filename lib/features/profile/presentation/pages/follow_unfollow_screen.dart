import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/features/profile/domain/profile_services.dart';
import 'package:audition/features/profile/model/followers_following_response.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/profile/presentation/widget/follow_unfollow_tile.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class FollowUnfollowScreen extends StatefulWidget {
  final UserData user;
  const FollowUnfollowScreen({super.key, required this.user});

  @override
  State<FollowUnfollowScreen> createState() => _FollowUnfollowScreenState();
}

class _FollowUnfollowScreenState extends State<FollowUnfollowScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Future<List<FollowerFollowingModel>?>? followerFollowingModel;
  ProfileServices profileServices = ProfileServices();
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    followerFollowingModel = profileServices.followerFollowingUserList(
        widget.user.id ?? "", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
      paddingOptional: false,
      title: widget.user.auditionId ?? widget.user.name ?? "",
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[300],
            indicatorColor: Colors.white,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: AppString.followers),
              Tab(text: AppString.following),
            ],
          ),
          10.verticalSpace,
          Expanded(
            child: FutureBuilder(
                future: followerFollowingModel,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const SizedBox.shrink();
                    default:
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        var followersList = snapshot.data?.first.followerList;
                        var followingList = snapshot.data?.first.followingList;
                        return TabBarView(controller: tabController, children: [
                          followersList!.isEmpty
                              ? Center(
                                  child: Text(AppString.noDataFound,
                                      style:
                                          CustomTextStyle.subTitleTextStyle()))
                              : FollowUnfollowTile(
                                  userList: followersList,
                                  fromBlockUsers: false,
                                  unfollowUser: (followerList) {},
                                ),
                          followingList!.isEmpty
                              ? Center(
                                  child: Text(AppString.noDataFound,
                                      style:
                                          CustomTextStyle.subTitleTextStyle()))
                              : FollowUnfollowTile(
                                  userList: followingList,
                                  fromBlockUsers: false,
                                  unfollowUser: (followerList) {
                                    profileServices.followUnfollowUser(
                                        followerList.id ?? "", false, context);
                                    followingList.removeWhere((element) =>
                                        element.id == followerList.id);
                                    setState(() {});
                                  },
                                )
                        ]);
                      }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
