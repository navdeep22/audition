import 'dart:io';

import 'package:audition/core/network/repository/api_services/api_service_account_verification.dart';
import 'package:audition/features/account_verification/model/all_verify_response_model.dart';
import 'package:audition/features/account_verification/model/bank_response_model.dart';
import 'package:audition/features/account_verification/model/pan_card_response_model.dart';
import 'package:flutter/material.dart';

class AccountVerificationServices {
  ApiServiceAccountVerification apiService = ApiServiceAccountVerification();

  Future<AllVerifyModel?> allVerify(BuildContext context) async {
    try {
      return await apiService.allVerify(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<bool?> verifyEmailAddress(
      String emailAddress, BuildContext context) async {
    try {
      return await apiService.verifyEmailAddress(emailAddress, context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<bool?> verifyOTP(
      String email, String otp, BuildContext context) async {
    apiService.verifyOTP(email, otp, context).then((onValue) {
      if (onValue) {
        return true;
      } else {
        return false;
      }
    });
    return null;
  }

  Future<bool?> addPanDetailsForVerification(String panName, String panNumber,
      String dob, File panImage, BuildContext context) async {
    return await apiService.addPanDetailsForVerification(
        panName, panNumber, dob, panImage, context);
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
    return await apiService.addBankDetailsForVerification(
        accountHolderName,
        accountNumber,
        bankName,
        branchName,
        ifscCode,
        state,
        bankImage,
        context);
  }

  Future<PanCardModel?> fetchPanCardDetails(BuildContext context) async {
    try {
      return await apiService.fetchPanCardDetails(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }

  Future<BankModel?> fetchBankdDetails(BuildContext context) async {
    try {
      return await apiService.fetchBankDetails(context);
    } on Exception catch (error) {
      throw Exception('Failed to fetch user profile: $error');
    }
  }
}
