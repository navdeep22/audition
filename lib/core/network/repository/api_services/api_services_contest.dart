import 'dart:convert';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/contests/challenges/domain/model/challenge_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/completed_contest_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_detail_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/contest_leaderboard_response_model.dart';
import 'package:audition/features/contests/challenges/domain/model/get_usable_balance_response_model.dart';
import 'package:flutter/material.dart';

class ApiServicesContest {
  var client = ApiClient();

  Future<List<ChallengesModel>?> getAllChallenges(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getAllContest);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ChallengesResponseModel challengesResponseModel =
          ChallengesResponseModel.fromJson(json);
      return challengesResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<ContestDetailModel?> getConteseDetails(
      String contestId, BuildContext context) async {
    var param = {Apikeys.contestId: contestId};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.leagueDetails)
        .replace(queryParameters: param);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ContestDetailResponse contestDetailResponse =
          ContestDetailResponse.fromJson(json);
      return contestDetailResponse.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<ContestLeaderResponse>?> getContestLeaderboard(
      String contestId, BuildContext context) async {
    var param = {Apikeys.contestId: contestId};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.myLeaderboard)
        .replace(queryParameters: param);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ContestLeaderBoardResponseModel contestLeaderBoardResponse =
          ContestLeaderBoardResponseModel.fromJson(json);
      return contestLeaderBoardResponse.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<CompletedContestData?> getCompltedContestLeaderBoard(
      String contestId, BuildContext context) async {
    var param = {Apikeys.contestId: contestId};
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.liveRanksLeaderboard)
            .replace(queryParameters: param);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      CompletedContestResponseModel completedContestResponseModel =
          CompletedContestResponseModel.fromJson(json);
      return completedContestResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<GetUsableBalanceResponse?> getUsableBalance(
      String contestId, BuildContext context) async {
    var param = {Apikeys.id: contestId};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getUsableBalance)
        .replace(queryParameters: param);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      GetUsableBalanceResponseModel getUsableBalanceResponse =
          GetUsableBalanceResponseModel.fromJson(json);
      return getUsableBalanceResponse.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }
}
