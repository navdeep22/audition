import 'dart:convert';
import 'dart:io';

import 'package:audition/core/data/app_exception.dart';
import 'package:audition/core/data/app_toast.dart';
import 'package:audition/core/network/apiclient.dart';
import 'package:audition/core/network/server_keys/apikeys.dart';
import 'package:audition/core/network/server_keys/app_storage_keys.dart';
import 'package:audition/core/network/server_keys/endpoints.dart';
import 'package:audition/features/account_verification/model/all_verify_response_model.dart';
import 'package:audition/features/account_verification/model/bank_response_model.dart';
import 'package:audition/features/account_verification/model/pan_card_response_model.dart';
import 'package:audition/resources/app_constants/app_string.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceAccountVerification {
  var client = ApiClient();

  Future<AllVerifyModel?> allVerify(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.allverify);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      AllVerifyResponseModel allVerifyResponseModel =
          AllVerifyResponseModel.fromJson(json);
      return allVerifyResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool?> verifyEmailAddress(
      String emailAddress, BuildContext context) async {
    var params = {Apikeys.email: emailAddress};
    final url =
        Uri.parse(APIEndpoints.baseUrl + APIEndpoints.verifyEmailAddress);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      appToast(msg: "Otp sent for email verification");
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<bool> verifyOTP(String email, String otp, BuildContext context) async {
    var params = {
      Apikeys.email: email,
      Apikeys.otp: otp,
    };
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.verifyOTP);
    final response = await client.post(url, body: params);
    if (response.statusCode == 200) {
      return true;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
      return false;
    }
  }

  Future<bool> addPanDetailsForVerification(String panName, String panNumber,
      String dob, File panImage, BuildContext context) async {
    var uri = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.panrequest);

    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppStorageKeys.loginToken);
    request.headers['Authorization'] = "Bearer ${token.toString()}";
    if (panImage.path.isNotEmpty) {
      var file = await http.MultipartFile.fromPath('image', panImage.path,
          filename: "PAN_Image.jpg");
      request.files.add(file);
    }

    request.fields['typename'] = 'pancard';
    request.fields['panname'] = panName;
    request.fields['pannumber'] = panNumber;
    request.fields['dob'] = dob;

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      appToast(msg: AppString.error);
      return false;
    }
  }

  Future<bool?> addBankDetailsForVerification(
      String accountHolderName,
      String accountNumber,
      String bankName,
      String branchName,
      String ifscCode,
      String state,
      File bankImage,
      BuildContext context) async {
    var uri = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.bankRequest);

    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(AppStorageKeys.loginToken);
    request.headers['Authorization'] = "Bearer ${token.toString()}";
    if (bankImage.path.isNotEmpty) {
      var file = await http.MultipartFile.fromPath('image', bankImage.path,
          filename: "BANK_Image.jpg");
      request.files.add(file);
    }

    request.fields['typename'] = 'bank';
    request.fields['accountholder'] = accountHolderName;
    request.fields['accno'] = accountNumber;
    request.fields['ifsc'] = ifscCode;
    request.fields['bankname'] = bankName;
    request.fields['ifsc'] = ifscCode;
    request.fields['bankbranch'] = branchName;
    request.fields['state'] = state;

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      appToast(msg: AppString.error);
      return false;
    }
  }

  Future<PanCardModel?> fetchPanCardDetails(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.panDetails);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      PanCardResponseModel panCardResponseModel =
          PanCardResponseModel.fromJson(json);
      return panCardResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }

  Future<BankModel?> fetchBankDetails(BuildContext context) async {
    final url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.bankDetails);

    final response = await client.get(url);
    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      BankResponseModel bankResponseModel = BankResponseModel.fromJson(json);
      return bankResponseModel.data;
    } else {
      if (context.mounted) {
        AppException.manageException(response, context);
      }
    }
    return null;
  }
}
