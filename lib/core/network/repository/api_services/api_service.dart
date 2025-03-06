import 'dart:convert';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/data/app_singleton/login_singleton.dart';
import 'package:audition/core/data/app_storage.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/repository/api_services/api_service_profile.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/onboarding/domain/onboarding_services.dart';
import 'package:flutter/material.dart';

class ApiService {
  var client = ApiClient();

  Future<bool> generateGuestToken(BuildContext context) async {
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.generateGuestToken);

    final response = await client.post(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AppStorage.saveToStorageString(
          AppStorageKeys.loginToken, json['data']['token']);
      AppStorage.saveToStorageBool(AppStorageKeys.isGuest, true);
      LoginSingleton().updateGuestUser(true);
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return false;
  }

  Future<bool> sendOTP(String mobile, BuildContext context) async {
    var params = {
      Apikeys.mobile: mobile,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.sendOTP);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return false;
  }

  Future<bool> verifyOTP(
      String mobile, String otp, BuildContext context) async {
    var params = {
      Apikeys.mobile: mobile,
      Apikeys.otp: otp,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.verifyOTP);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      AppStorage.saveToStorageString(
          AppStorageKeys.loginToken, json['data']['token']);
      AppStorage.saveToStorageBool(AppStorageKeys.isGuest, false);
      LoginSingleton().updateGuestUser(false);
      ApiServiceProfile().fetchUserDetails(context);
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
      return false;
    }
  }

  Future<bool> checkContest(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.checkContest);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      showContest = json['data']['check'];
      //showContest = true;
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
      return false;
    }
  }
}
