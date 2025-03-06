// To parse this JSON data, do
//
//     final searchResultResponseModel = searchResultResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:audition/features/home/model/all_video_response_model.dart';

SearchResultResponseModel searchResultResponseModelFromJson(String str) =>
    SearchResultResponseModel.fromJson(json.decode(str));

class SearchResultResponseModel {
  bool? success;
  String? message;
  SearchData? data;

  SearchResultResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory SearchResultResponseModel.fromJson(Map<String, dynamic> json) =>
      SearchResultResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : SearchData.fromJson(json["data"]),
      );
}

class SearchData {
  List<UserElement>? users;
  List<Hashtag>? hashtags;
  List<VideoResponse>? data;

  SearchData({
    this.users,
    this.hashtags,
    this.data,
  });

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        users: json["users"] == null
            ? []
            : List<UserElement>.from(
                json["users"]!.map((x) => UserElement.fromJson(x))),
        hashtags: json["hashtags"] == null
            ? []
            : List<Hashtag>.from(
                json["hashtags"]!.map((x) => Hashtag.fromJson(x))),
        data: json["data"] == null
            ? []
            : List<VideoResponse>.from(
                json["data"]!.map((x) => VideoResponse.fromJson(x))),
      );
}

class Hashtag {
  String? id;
  String? name;
  int? videos;

  Hashtag({
    this.id,
    this.name,
    this.videos,
  });

  factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
        id: json["_id"],
        name: json["Name"],
        videos: json["Videos"],
      );
}

class UserElement {
  String? id;
  String? image;
  String? name;
  String? auditionId;
  bool? isSelf;
  bool? followStatus;
  int? followersCount;

  UserElement({
    this.id,
    this.image,
    this.name,
    this.auditionId,
    this.isSelf,
    this.followStatus,
    this.followersCount,
  });

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        id: json["_id"],
        image: json["image"],
        name: json["name"],
        auditionId: json["audition_id"],
        isSelf: json["is_self"],
        followStatus: json["follow_status"],
        followersCount: json["followers_count"],
      );
}
