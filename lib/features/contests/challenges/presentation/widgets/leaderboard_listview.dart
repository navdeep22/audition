import 'package:audition/core/data/app_toast.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_leaderboard_response_model.dart';
import 'package:audition/features/home/domain/home_services.dart';
import 'package:audition/features/onboarding/presentation/widget/style/container_style/container_style.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/cache_images.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeaderboardListview extends StatelessWidget {
  final List<ContestLeaderResponse>? contestLeaderBoard;
  final bool isUpcoming;
  final String contestId;
  const LeaderboardListview(
      {super.key,
      required this.contestLeaderBoard,
      required this.isUpcoming,
      required this.contestId});

  @override
  Widget build(BuildContext context) {
    contestLeaderBoard?.sort((a, b) => b.votes!.compareTo(a.votes!));
    return ListView.builder(
        itemCount: contestLeaderBoard?.length ?? 0,
        itemBuilder: (context, index) {
          var leaderboard = contestLeaderBoard?[index];

          return GestureDetector(
            onTap: () async {
              if (isUpcoming) {
                appToast(msg: "Contest Not Started Yet.");
              } else {
                await HomeServices()
                    .fetchVideosForContestByUserAndContestId(
                        leaderboard.userid ?? "", contestId, context)
                    .then((onValue) {
                  AppNavigator.navigateToFeedsScreen(
                      context, onValue, PageController(initialPage: 0));
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: ContainerStyle.appGradientViewContainer(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        leaderboard?.image == ""
                            ? const Icon(
                                FontAwesomeIcons.solidCircleUser,
                                color: Colors.white,
                                size: 40,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CacheImages(
                                        imagePath: leaderboard?.image ?? "")),
                              ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(leaderboard?.name ?? "",
                                style: CustomTextStyle.subTitleTextStyle()),
                            Text(leaderboard?.auditionId ?? "",
                                style: CustomTextStyle.descTextStyle()),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Rank #1", style: CustomTextStyle.descTextStyle()),
                        15.horizontalSpace,
                        const Icon(Icons.thumb_up_alt,
                            color: Colors.white, size: 20),
                        5.horizontalSpace,
                        Text(leaderboard!.votes!.toString(),
                            style: CustomTextStyle.descTextStyle()),
                      ],
                    )
                  ]),
            ),
          );
        });
  }
}
