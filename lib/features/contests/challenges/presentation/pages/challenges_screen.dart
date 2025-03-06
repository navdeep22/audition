import 'package:audition/features/contests/challenges/domain/challenge_services.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/challenge_header_area.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/challenge_listing.dart';
import 'package:audition/features/onboarding/presentation/widget/parent_widget.dart';
import 'package:audition/features/onboarding/presentation/widget/style/text_style/text_style.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:flutter/material.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  ChallengeServices challengeServices = ChallengeServices();
  Future<List<ChallengesModel>?>? challengeModel;
  String selectedFilter = AppString.upcoming;
  @override
  void initState() {
    challengeModel = challengeServices.getChallenges(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      paddingOptional: true,
      child: FutureBuilder(
          future: challengeModel,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const SizedBox.shrink();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<ChallengesModel>? challenges = [];
                  challenges = snapshot.data ?? [];
                  var upcomingContest = challenges
                      .where((contest) =>
                          contest.status == "notstarted" &&
                          contest.finalStatus == "pending")
                      .toList();
                  var liveContest = challenges
                      .where((contest) =>
                          contest.status == "started" &&
                          contest.finalStatus == "pending")
                      .toList();
                  var completedContest = challenges
                      .where((contest) =>
                          contest.finalStatus == "winnerdeclared" ||
                          contest.finalStatus == "IsReviewed")
                      .toList();
                  List<ChallengesModel>? selectedChallengesList = [];
                  if (selectedFilter == AppString.upcoming) {
                    selectedChallengesList = upcomingContest;
                  } else if (selectedFilter == AppString.live) {
                    selectedChallengesList = liveContest;
                  } else if (selectedFilter == AppString.completed) {
                    selectedChallengesList = completedContest;
                  }
                  return Column(children: [
                    ChallengeHeaderArea(
                        onFilterChanged: changeChallengeFilter,
                        selectedFilter: selectedFilter),
                    selectedChallengesList.isNotEmpty
                        ? ChallengeListing(
                            challenges: selectedChallengesList,
                            isCompletedContest:
                                selectedFilter == AppString.completed,
                            isUpcoming: selectedFilter == AppString.upcoming)
                        : Padding(
                            padding: const EdgeInsets.only(top: 200),
                            child: Center(
                                child: Text(AppString.noDataFound,
                                    style:
                                        CustomTextStyle.subTitleTextStyle())))
                  ]);
                }
            }
          }),
    );
  }

  void changeChallengeFilter(String filterSelected) {
    setState(() {
      selectedFilter = filterSelected;
    });
  }
}
