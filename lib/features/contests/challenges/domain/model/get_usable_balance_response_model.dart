// To parse this JSON data, do
//
//     final getUsableBalanceResponseModel = getUsableBalanceResponseModelFromJson(jsonString);

import 'dart:convert';

GetUsableBalanceResponseModel getUsableBalanceResponseModelFromJson(
        String str) =>
    GetUsableBalanceResponseModel.fromJson(json.decode(str));

class GetUsableBalanceResponseModel {
  bool? success;
  String? message;
  GetUsableBalanceResponse? data;

  GetUsableBalanceResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetUsableBalanceResponseModel.fromJson(Map<String, dynamic> json) =>
      GetUsableBalanceResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : GetUsableBalanceResponse.fromJson(json["data"]),
      );
}

class GetUsableBalanceResponse {
  String? usablebalance;
  String? usertotalbalance;
  String? entryfee;
  String? bonus;

  GetUsableBalanceResponse({
    this.usablebalance,
    this.usertotalbalance,
    this.entryfee,
    this.bonus,
  });

  factory GetUsableBalanceResponse.fromJson(Map<String, dynamic> json) =>
      GetUsableBalanceResponse(
        usablebalance: json["usablebalance"],
        usertotalbalance: json["usertotalbalance"],
        entryfee: json["entryfee"],
        bonus: json["bonus"],
      );
}
