import 'dart:io';

import 'package:audition/core/data/app_toast.dart';
import 'package:audition/core/network/repository/api_services/api_service_profile.dart';
import 'package:audition/features/home/model/all_video_response_model.dart';
import 'package:audition/features/notifications/model/notification_response_model.dart';
import 'package:audition/features/profile/model/followers_following_response.dart';
import 'package:audition/features/profile/model/user_full_details_model.dart';
import 'package:audition/features/wallet/model/all_transactions_response_model.dart';
import 'package:audition/features/wallet/model/request_add_cash_response_model.dart';
import 'package:flutter/material.dart';

class ProfileServices {
  ApiServiceProfile apiService = ApiServiceProfile();

  Future<UserData?> getUserProfile(BuildContext context) async {
    try {
      return await apiService.fetchUserDetails(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<void> editUserProfile(
      String name,
      String mobileNumber,
      String bio,
      String gender,
      String dob,
      File profileImage,
      BuildContext context) async {
    try {
      await apiService
          .updateUserDetails(
              name, mobileNumber, bio, gender, dob, profileImage, context)
          .then((onValue) {
        if (onValue) {
          appToast(msg: "User details updated");
          Navigator.pop(context);
        }
      });
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<List<VideoResponse>?> fetchUserVideos(
      String userId, BuildContext context) {
    return apiService.fetchUserVideos(userId, context);
  }

  Future<UserData?> getOtherUserProfileDetailsByAudtionId(
      String auditionId, BuildContext context) async {
    try {
      return await apiService.fetchOtherUserDetailsByAuditionId(
          auditionId, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<UserData?> getOtherUserProfileDetailsById(
      String otherUserId, BuildContext context) async {
    try {
      return await apiService.fetchOtherUserDetailsById(otherUserId, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<bool?> reportUser(
      String userId, String reportId, BuildContext context) async {
    try {
      return await apiService.reportUser(userId, reportId, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<bool?> blockUnBlocktUser(
      String userId, bool status, BuildContext context) async {
    try {
      return await apiService.blockUnBlockUser(userId, status, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<bool?> followUnfollowUser(
      String userId, bool status, BuildContext context) async {
    try {
      return await apiService.followUnfollowUser(userId, status, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<List<FollowerFollowingModel>?> followerFollowingUserList(
      String userId, BuildContext context) async {
    try {
      return apiService.followerFollowingUserList(userId, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<List<FollowerList>?> blockedUserList(BuildContext context) async {
    try {
      return apiService.blockedUserList(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<List<AllTransactionModel>?> getAllTransactions(
      BuildContext context) async {
    try {
      return apiService.getAllTransactions(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<List<NotificationModel>?> fetchAllNotifications(
      BuildContext context) async {
    try {
      return apiService.fetchAllNotifications(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<RequestAddCashModel?> requestAddCash(
      String amount, BuildContext context) async {
    try {
      return await apiService.requestAddCash(amount, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }
}
