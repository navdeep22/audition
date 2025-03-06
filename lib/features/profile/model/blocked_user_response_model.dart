// To parse this JSON data, do
//
//     final blockedUsersResponseModel = blockedUsersResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:audition/features/profile/model/followers_following_response.dart';

BlockedUsersResponseModel blockedUsersResponseModelFromJson(String str) =>
    BlockedUsersResponseModel.fromJson(json.decode(str));

class BlockedUsersResponseModel {
  bool? success;
  String? message;
  List<FollowerList>? data;

  BlockedUsersResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory BlockedUsersResponseModel.fromJson(Map<String, dynamic> json) =>
      BlockedUsersResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<FollowerList>.from(
                json["data"]!.map((x) => FollowerList.fromJson(x))),
      );
}
