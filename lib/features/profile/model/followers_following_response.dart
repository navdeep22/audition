// To parse this JSON data, do
//
//     final followerFollowingResponseModel = followerFollowingResponseModelFromJson(jsonString);

import 'dart:convert';

FollowerFollowingResponseModel followerFollowingResponseModelFromJson(
        String str) =>
    FollowerFollowingResponseModel.fromJson(json.decode(str));

class FollowerFollowingResponseModel {
  String? message;
  bool? success;
  List<FollowerFollowingModel>? data;

  FollowerFollowingResponseModel({
    this.message,
    this.success,
    this.data,
  });

  factory FollowerFollowingResponseModel.fromJson(Map<String, dynamic> json) =>
      FollowerFollowingResponseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<FollowerFollowingModel>.from(
                json["data"]!.map((x) => FollowerFollowingModel.fromJson(x))),
      );
}

class FollowerFollowingModel {
  String? id;
  String? email;
  int? followersCount;
  int? followingCount;
  List<FollowerList>? followingList;
  List<FollowerList>? followerList;

  FollowerFollowingModel({
    this.id,
    this.email,
    this.followersCount,
    this.followingCount,
    this.followingList,
    this.followerList,
  });

  factory FollowerFollowingModel.fromJson(Map<String, dynamic> json) =>
      FollowerFollowingModel(
        id: json["_id"],
        email: json["email"],
        followersCount: json["followers_count"],
        followingCount: json["following_count"],
        followingList: json["followingList"] == null
            ? []
            : List<FollowerList>.from(
                json["followingList"]!.map((x) => FollowerList.fromJson(x))),
        followerList: json["followerList"] == null
            ? []
            : List<FollowerList>.from(
                json["followerList"]!.map((x) => FollowerList.fromJson(x))),
      );
}

class FollowerList {
  String? id;
  String? image;
  String? name;
  String? auditionId;
  String? email;
  int? followersCount;
  bool? followStatus;

  FollowerList({
    this.id,
    this.image,
    this.name,
    this.auditionId,
    this.email,
    this.followersCount,
    this.followStatus,
  });

  factory FollowerList.fromJson(Map<String, dynamic> json) => FollowerList(
        id: json["_id"],
        image: json["image"],
        name: json["name"],
        auditionId: json["audition_id"],
        email: json["email"],
        followersCount: json["followers_count"],
        followStatus: json["follow_status"],
      );
}
