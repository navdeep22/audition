import 'dart:async';

import 'package:audition/features/contests/challenges/domain/challenge_services.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/completed_contest_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_detail_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_leaderboard_response_model.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/contest_details.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/leaderboard_listview.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/leaderboard_listview_completed.dart';
import 'package:audition/features/contests/challenges/presentation/widgets/prize_card_listview.dart';
import 'package:audition/features/home/presentation/widgets/round_buttons.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:audition/resources/helpers/extensions.dart';
import 'package:audition/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class ContestDetailsScreen extends StatefulWidget {
  final ChallengesModel challengesModel;
  final bool isUpcoming;
  final bool isCompletedContest;
  const ContestDetailsScreen(
      {super.key,
      required this.challengesModel,
      required this.isCompletedContest,
      required this.isUpcoming});

  @override
  State<ContestDetailsScreen> createState() => _ContestDetailsScreenState();
}

class _ContestDetailsScreenState extends State<ContestDetailsScreen> {
  bool isLeaderBoardSelected = false;
  Future<ContestDetailModel?>? contestDetail;

  Future<List<ContestLeaderResponse>?>? contestLeaderBoard;
  Future<CompletedContestData?>? completedContestLeaderBoard;
  ChallengeServices challengeServices = ChallengeServices();
  @override
  void initState() {
    contestDetail = challengeServices.getContestDetails(
        widget.challengesModel.id ?? "", context);
    contestLeaderBoard = challengeServices.getContestLeaderBoard(
        widget.challengesModel.id ?? "", context);
    completedContestLeaderBoard =
        challengeServices.getCompltedContestLeaderBoard(
            widget.challengesModel.id ?? "", context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalAppBar(
        paddingOptional: false,
        title: AppString.contestDetails,
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: Column(
            children: [
              ContestDetails(
                  showTopBanner: false,
                  challengesModel: widget.challengesModel),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundButtons(
                      isSelected: !isLeaderBoardSelected,
                      title: AppString.prizeCard,
                      onTap: (text) {
                        if (isLeaderBoardSelected) {
                          toggleSelection();
                        }
                      }),
                  RoundButtons(
                      isSelected: isLeaderBoardSelected,
                      title: AppString.leaderboard,
                      onTap: (text) {
                        if (!isLeaderBoardSelected) {
                          toggleSelection();
                        }
                      })
                ],
              ),
              10.verticalSpace,
              Expanded(
                  child: isLeaderBoardSelected
                      ? FutureBuilder(
                          future: widget.isCompletedContest
                              ? completedContestLeaderBoard
                              : contestLeaderBoard,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const SizedBox.shrink();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  if (!widget.isCompletedContest) {
                                    var leaderboardData = snapshot.data
                                        as List<ContestLeaderResponse>;
                                    return LeaderboardListview(
                                      contestId:
                                          widget.challengesModel.id ?? "",
                                      contestLeaderBoard: leaderboardData,
                                      isUpcoming: widget.isUpcoming,
                                    );
                                  } else {
                                    var leaderboardData =
                                        snapshot.data as CompletedContestData;
                                    return CompletedLeaderboardListview(
                                        contestId:
                                            widget.challengesModel.id ?? "",
                                        completedContestLeaderBoard:
                                            leaderboardData.jointeams);
                                  }
                                }
                            }
                          })
                      : FutureBuilder(
                          future: contestDetail,
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return const SizedBox.shrink();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  var contestDetails = snapshot.data;
                                  return PrizeCardListview(
                                      challengesModel: contestDetails ??
                                          ContestDetailModel());
                                }
                            }
                          }))
            ],
          ),
        ));
  }

  void toggleSelection() {
    setState(() {
      isLeaderBoardSelected = !isLeaderBoardSelected;
    });
  }
}
