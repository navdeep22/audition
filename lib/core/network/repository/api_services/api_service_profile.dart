import 'dart:convert';
import 'dart:io';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/data/app_singleton/user_singleton.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/notifications/model/notification_response_model.dart';
import 'package:audition/features/profile/model/blocked_user_response_model.dart';
import 'package:audition/features/profile/model/followers_following_response.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/wallet/model/all_transactions_response_model.dart';
import 'package:audition/features/wallet/model/request_add_cash_response_model.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServiceProfile {
  var client = ApiClient();

  Future<UserData?> fetchUserDetails(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.userFullDetails);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      UserFullDetails userFullDetails = UserFullDetails.fromJson(json);
      UserSingleton().updateUserData(userFullDetails.data);
      return userFullDetails.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool> updateUserDetails(
      String name,
      String mobileNumber,
      String bio,
      String gender,
      String dob,
      File profileImage,
      BuildContext context) async {
    var uri = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.editUserDetails);

    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppStorageKeys.loginToken);
    request.headers['Authorization'] = "Bearer ${token.toString()}";
    if (profileImage.path.isNotEmpty) {
      var file = await http.MultipartFile.fromPath(
        'image',
        profileImage.path,
      );
      request.files.add(file);
    }

    request.fields['typename'] = 'user-profiles';
    request.fields['name'] = name;
    request.fields['audition_id'] = UserSingleton().userData?.auditionId ?? "";
    request.fields['bio'] = bio;
    request.fields['gender'] = gender;
    request.fields['dob'] = dob;

    var response = await request.send();

    if (response.statusCode == 200) {
      fetchUserDetails(context);
      return true;
    } else {
      appToast(msg: AppString.error);
      return false;
    }
  }

  Future<List<VideoResponse>?> fetchUserVideos(
      String userId, BuildContext context) async {
    var params = {Apikeys.id: userId};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getUserVideo)
        .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AllVideoResponseModel allVideoResponseModel =
          AllVideoResponseModel.fromJson(json);
      return allVideoResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<UserData?> fetchOtherUserDetailsByAuditionId(
      String otherAuditionId, BuildContext context) async {
    var params = {Apikeys.auditionId: otherAuditionId};
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getUserByAuditionId)
            .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      UserFullDetails userFullDetails = UserFullDetails.fromJson(json);
      return userFullDetails.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<UserData?> fetchOtherUserDetailsById(
      String userId, BuildContext context) async {
    var params = {Apikeys.userId: userId};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getUserList)
        .replace(queryParameters: params);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        OtherUserResponseModel userFullDetails =
            OtherUserResponseModel.fromJson(json);
        return userFullDetails.data?.first;
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

  Future<bool?> reportUser(
      String reportuserid, String reportId, BuildContext context) async {
    var params = {
      Apikeys.reportuserid: reportuserid,
      Apikeys.reportId: reportId,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.addReportUser)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "Successfully reported this user");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> blockUnBlockUser(
      String blockId, bool status, BuildContext context) async {
    var params = {
      Apikeys.blockId: blockId,
      Apikeys.status: status ? "blocked" : "unblocked",
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.userBlockUnblock)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(msg: "Successfully blocked this user");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> followUnfollowUser(
      String userId, bool status, BuildContext context) async {
    var params = {
      Apikeys.followingId: userId,
      Apikeys.status: status ? "followed" : "unfollowed",
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.followUnfollow)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      appToast(
          msg: "Successfully ${status ? "followed" : "Unfollowed"} this user");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<FollowerFollowingModel>?> followerFollowingUserList(
      String userId, BuildContext context) async {
    var params = {Apikeys.id: userId};

    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getFollowerList)
        .replace(queryParameters: params);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      FollowerFollowingResponseModel followerFollowingResponseModel =
          FollowerFollowingResponseModel.fromJson(json);
      return followerFollowingResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<FollowerList>?> blockedUserList(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getBlockedUser);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      BlockedUsersResponseModel blockedUsersResponseModel =
          BlockedUsersResponseModel.fromJson(json);
      return blockedUsersResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<AllTransactionModel>?> getAllTransactions(
      BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getTransactions);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      AllTransactionResponseModel allTransactionResponseModel =
          AllTransactionResponseModel.fromJson(json);
      return allTransactionResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<List<NotificationModel>?> fetchAllNotifications(
      BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.getNotification);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      NotificationResponseModel notificationResponseModel =
          NotificationResponseModel.fromJson(json);
      return notificationResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<RequestAddCashModel?> requestAddCash(
      String amount, BuildContext context) async {
    var params = {Apikeys.amount: amount, Apikeys.paymentby: "razorpay"};
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.requestAddCash);

    final response = await client.post(url, body: params);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      RequestAddCashResponseModel requestAddCashResponseModel =
          RequestAddCashResponseModel.fromJson(json);

      return requestAddCashResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool> uploadMusic(File audioFile, BuildContext context) async {
    var uri = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.uploadMusic);

    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppStorageKeys.loginToken);
    request.headers['Authorization'] = "Bearer ${token.toString()}";
    if (audioFile.path.isNotEmpty) {
      var file = await http.MultipartFile.fromPath(
        'audio',
        audioFile.path,
      );
      request.files.add(file);
    }

    request.fields['typename'] = 'musicUpload/mp3';
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      debugPrint("================");
      debugPrint(jsonResponse);
      debugPrint("================");
      return true;
    } else {
      appToast(msg: AppString.error);
      return false;
    }
  }
}
