// To parse this JSON data, do
//
//     final allVerifyResponseModel = allVerifyResponseModelFromJson(jsonString);

import 'dart:convert';

AllVerifyResponseModel allVerifyResponseModelFromJson(String str) =>
    AllVerifyResponseModel.fromJson(json.decode(str));

class AllVerifyResponseModel {
  String? message;
  bool? success;
  AllVerifyModel? data;

  AllVerifyResponseModel({
    this.message,
    this.success,
    this.data,
  });

  factory AllVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      AllVerifyResponseModel(
        message: json["message"],
        success: json["success"],
        data:
            json["data"] == null ? null : AllVerifyModel.fromJson(json["data"]),
      );
}

class AllVerifyModel {
  int? mobileVerify;
  int? emailVerify;
  int? bankVerify;
  int? panVerify;
  int? profileImageVerify;
  String? image;
  String? email;
  int? mobile;
  String? panComment;
  String? bankComment;

  AllVerifyModel({
    this.mobileVerify,
    this.emailVerify,
    this.bankVerify,
    this.panVerify,
    this.profileImageVerify,
    this.image,
    this.email,
    this.mobile,
    this.panComment,
    this.bankComment,
  });

  factory AllVerifyModel.fromJson(Map<String, dynamic> json) => AllVerifyModel(
        mobileVerify: json["mobile_verify"],
        emailVerify: json["email_verify"],
        bankVerify: json["bank_verify"],
        panVerify: json["pan_verify"],
        profileImageVerify: json["profile_image_verify"],
        image: json["image"],
        email: json["email"],
        mobile: json["mobile"],
        panComment: json["pan_comment"],
        bankComment: json["bank_comment"],
      );
}
