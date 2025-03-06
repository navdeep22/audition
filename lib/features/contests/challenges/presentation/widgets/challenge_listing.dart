import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/contest_details.dart';
import 'package:audition/resources/helpers/app_navigator.dart';
import 'package:flutter/material.dart';

class ChallengeListing extends StatelessWidget {
  final List<ChallengesModel> challenges;
  final bool isCompletedContest;
  final bool isUpcoming;
  const ChallengeListing(
      {super.key,
      required this.challenges,
      required this.isCompletedContest,
      required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.68,
      child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: challenges.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  AppNavigator.navigateToContestDetailScreen(challenges[index],
                      context, isCompletedContest, isUpcoming);
                },
                child: ContestDetails(
                    showTopBanner: true, challengesModel: challenges[index]));
          }),
    );
  }
}
