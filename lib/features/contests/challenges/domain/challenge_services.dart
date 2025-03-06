import 'package:audition/core/network/repository/api_services/api_services_contest.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/completed_contest_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_detail_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_leaderboard_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/get_usable_balance_response_model.dart';
import 'package:flutter/material.dart';

class ChallengeServices {
  ApiServicesContest apiService = ApiServicesContest();

  Future<List<ChallengesModel>?> getChallenges(BuildContext context) async {
    return await apiService.getAllChallenges(context);
  }

  Future<ContestDetailModel?> getContestDetails(
      String contestId, BuildContext context) async {
    return await apiService.getConteseDetails(contestId, context);
  }

  Future<List<ContestLeaderResponse>?> getContestLeaderBoard(
      String contestId, BuildContext context) async {
    return await apiService.getContestLeaderboard(contestId, context);
  }

  Future<CompletedContestData?> getCompltedContestLeaderBoard(
      String contestId, BuildContext context) async {
    return await apiService.getCompltedContestLeaderBoard(contestId, context);
  }

  Future<GetUsableBalanceResponse?> getUsableBalance(
      String contestId, BuildContext context) async {
    return await apiService.getUsableBalance(contestId, context);
  }
}
