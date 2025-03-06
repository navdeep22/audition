// To parse this JSON data, do
//
//     final trendingResultResponseModel = trendingResultResponseModelFromJson(jsonString);

import 'dart:convert';

TrendingResultResponseModel trendingResultResponseModelFromJson(String str) =>
    TrendingResultResponseModel.fromJson(json.decode(str));

class TrendingResultResponseModel {
  bool? success;
  String? message;
  Data? data;

  TrendingResultResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory TrendingResultResponseModel.fromJson(Map<String, dynamic> json) =>
      TrendingResultResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  List<TrendingResponse>? data;
  List<String>? images;

  Data({
    this.data,
    this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"] == null
            ? []
            : List<TrendingResponse>.from(
                json["data"]!.map((x) => TrendingResponse.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
      );
}

class TrendingResponse {
  String? id;
  String? name;
  int? views;
  List<Video>? videos;

  TrendingResponse({
    this.id,
    this.name,
    this.views,
    this.videos,
  });

  factory TrendingResponse.fromJson(Map<String, dynamic> json) =>
      TrendingResponse(
        id: json["_id"],
        name: json["name"],
        views: json["views"],
        videos: json["videos"] == null
            ? []
            : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
      );
}

class Video {
  String? id;
  String? caption;
  String? language;
  String? location;
  List<int>? coordinates;
  String? userId;
  String? file;
  List<String>? usersLike;
  int? likeCount;
  String? status;
  bool? enabled;
  String? contestStatus;
  bool? checked;
  bool? wrongContent;
  List<dynamic>? comment;
  bool? private;
  int? shares;
  String? songLink;
  String? postId;
  int? views;
  String? vId;
  List<String>? hashtag;
  String? hashtagId;
  bool? isAllowSharing;
  bool? isAllowDuet;
  bool? isAllowComment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? index;
  String? hashName;
  bool? isSelf;
  int? commentCount;
  bool? likeStatus;
  bool? followStatus;
  String? auditionId;
  String? image;
  bool? isSaved;

  Video({
    this.id,
    this.caption,
    this.language,
    this.location,
    this.coordinates,
    this.userId,
    this.file,
    this.usersLike,
    this.likeCount,
    this.status,
    this.enabled,
    this.contestStatus,
    this.checked,
    this.wrongContent,
    this.comment,
    this.private,
    this.shares,
    this.songLink,
    this.postId,
    this.views,
    this.vId,
    this.hashtag,
    this.hashtagId,
    this.isAllowSharing,
    this.isAllowDuet,
    this.isAllowComment,
    this.createdAt,
    this.updatedAt,
    this.index,
    this.hashName,
    this.isSelf,
    this.commentCount,
    this.likeStatus,
    this.followStatus,
    this.auditionId,
    this.image,
    this.isSaved,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["_id"],
        caption: json["caption"],
        language: json["language"],
        location: json["location"],
        coordinates: json["coordinates"] == null
            ? []
            : List<int>.from(json["coordinates"]!.map((x) => x)),
        userId: json["userId"],
        file: json["file"],
        usersLike: json["users_like"] == null
            ? []
            : List<String>.from(json["users_like"]!.map((x) => x)),
        likeCount: json["like_count"],
        status: json["status"],
        enabled: json["enabled"],
        contestStatus: json["contest_status"],
        checked: json["checked"],
        wrongContent: json["wrongContent"],
        comment: json["comment"] == null
            ? []
            : List<dynamic>.from(json["comment"]!.map((x) => x)),
        private: json["private"],
        shares: json["shares"],
        songLink: json["songLink"],
        postId: json["postId"],
        views: json["views"],
        vId: json["vId"],
        hashtag: json["hashtag"] == null
            ? []
            : List<String>.from(json["hashtag"]!.map((x) => x)),
        hashtagId: json["hashtagId"],
        isAllowSharing: json["isAllowSharing"],
        isAllowDuet: json["isAllowDuet"],
        isAllowComment: json["isAllowComment"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        index: json["index"],
        hashName: json["hashName"],
        isSelf: json["is_self"],
        commentCount: json["comment_count"],
        likeStatus: json["like_status"],
        followStatus: json["follow_status"],
        auditionId: json["audition_id"],
        image: json["image"],
        isSaved: json["isSaved"],
      );
}
