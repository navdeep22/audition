import 'dart:convert';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/core/domain/providers/home_videos_providers.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/home/model/get_live_contest_response_model.dart';
import 'package:audition/features/home/model/report_response_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiServiceHome {
  var client = ApiClient();
  Future<List<VideoResponse>?> fetchVideos(
      String language, BuildContext context) async {
    var params = {Apikeys.language: language};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getVideos)
        .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        AllVideoResponseModel videoResponseModel =
            AllVideoResponseModel.fromJson(json);
        Provider.of<HomeVideosProviders>(context, listen: false)
            .setAllVideos(videoResponseModel.data);
        return videoResponseModel.data;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<VideoResponse>?> fetchVideosForContest(
      BuildContext context) async {
    var language =
        await AppStorage.getStorageValueString(AppStorageKeys.langauge);
    var params = {Apikeys.language: language};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.contestVideo)
        .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        AllVideoResponseModel videoResponseModel =
            AllVideoResponseModel.fromJson(json);
        return videoResponseModel.data;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<LiveContestModel>?> fetchLiveContestCategories(
      BuildContext context) async {
    var language =
        await AppStorage.getStorageValueString(AppStorageKeys.langauge);
    var params = {Apikeys.language: language};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getLiveContest)
        .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        GetLiveContestResponseModel getLiveContestResponseModel =
            GetLiveContestResponseModel.fromJson(json);
        return getLiveContestResponseModel.data;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<String>?> fetchAllLanguages(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.languages);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return List<String>.from(json["data"][0]["languages"]);
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<String?> checkForMainBanner(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getWebSlider);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return json["data"]["image"];
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> likeAndUnlineVideo(
      String videoId, bool status, BuildContext context) async {
    var params = {
      Apikeys.videoId: videoId,
      Apikeys.status: status ? "liked" : "unlike",
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.likeUnlike)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<ReportModel>?> fetchReportsList(BuildContext context) async {
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getReportCategory);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ReportResponseModel reportResponseModel =
          ReportResponseModel.fromJson(json);
      return reportResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<ReportModel>?> fetchNotInterestList(BuildContext context) async {
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.interestCategories);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      ReportResponseModel reportResponseModel =
          ReportResponseModel.fromJson(json);
      return reportResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> watchLaterVideo(String videoId, BuildContext context) async {
    final url =
        Uri.parse("${APIEndpoints.baseUrl}${APIEndpoints.watchLater}/$videoId");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "Video added to watch later");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> removeFromWatchList(
      String videoId, BuildContext context) async {
    final url = Uri.parse(
        "${APIEndpoints.baseUrl}${APIEndpoints.removeFromWatchLater}/$videoId");
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "Video removed from watch later");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> reportVideo(
      String videoId, String reportId, BuildContext context) async {
    var params = {
      Apikeys.videoId: videoId,
      Apikeys.reportId: reportId,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.reportVideo)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "Successfully reported this video");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> notIntrestedVideo(
      String videoId, String notIntrestedId, BuildContext context) async {
    var params = {
      Apikeys.videoId: videoId,
      Apikeys.catId: notIntrestedId,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.notIntrested)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "This video is hidden Successfully");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> followUnfollow(
      String videoId, String notIntrestedId, BuildContext context) async {
    var params = {
      Apikeys.videoId: videoId,
      Apikeys.catId: notIntrestedId,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.notIntrested)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "This video is hidden Successfully");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<VideoResponse>?> fetchVideosForContestByUserAndContestId(
      String userId, String contestId, BuildContext context) async {
    var params = {Apikeys.userid: userId, Apikeys.challengeid: contestId};
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.contestVideoByUser)
            .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        AllVideoResponseModel videoResponseModel =
            AllVideoResponseModel.fromJson(json);
        return videoResponseModel.data;
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }
}
