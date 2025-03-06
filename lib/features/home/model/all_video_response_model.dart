// To parse this JSON data, do
//
//     final allVideoResponseModel = allVideoResponseModelFromJson(jsonString);

import 'dart:convert';

AllVideoResponseModel allVideoResponseModelFromJson(String str) =>
    AllVideoResponseModel.fromJson(json.decode(str));

class AllVideoResponseModel {
  final String? message;
  final bool? success;
  final List<VideoResponse>? data;

  AllVideoResponseModel({
    this.message,
    this.success,
    this.data,
  });

  factory AllVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      AllVideoResponseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<VideoResponse>.from(
                json["data"]!.map((x) => VideoResponse.fromJson(x))),
      );
}

class VideoResponse {
  final String? id;
  final String? caption;
  final String? language;
  final String? location;
  final List<int>? coordinates;
  String? userId;
  final String? file;
  final List<String>? usersLike;
  int? likeCount;
  final String? status;
  final bool? enabled;
  final String? contestStatus;
  final bool? checked;
  final bool? wrongContent;
  final List<Comment>? comment;
  final bool? private;
  final int? shares;
  final String? songLink;
  final String? postId;
  final int? views;
  final String? vId;
  final List<String>? hashtag;
  final List<String>? hashtagId;
  final bool? isAllowSharing;
  final bool? isAllowDuet;
  final bool? isAllowComment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic string;
  final dynamic voteStatus;
  final bool? isSelf;
  final int? commentCount;
  bool? likeStatus;
  bool? followStatus;
  String? auditionId;
  final String? image;
  final bool? isBoosted;
  final List<Vote>? votes;
  bool? isSaved;
  final String? songId;
  final Song? song;

  VideoResponse({
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
    this.string,
    this.voteStatus,
    this.isSelf,
    this.commentCount,
    this.likeStatus,
    this.followStatus,
    this.auditionId,
    this.image,
    this.isBoosted,
    this.votes,
    this.isSaved,
    this.songId,
    this.song,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
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
            : List<Comment>.from(
                json["comment"]!.map((x) => Comment.fromJson(x))),
        private: json["private"],
        shares: json["shares"],
        songLink: json["songLink"],
        postId: json["postId"],
        views: json["views"],
        vId: json["vId"],
        hashtag: json["hashtag"] == null
            ? []
            : List<String>.from(json["hashtag"]!.map((x) => x)),
        hashtagId: json["hashtagId"] == null
            ? []
            : List<String>.from(json["hashtagId"]!.map((x) => x)),
        isAllowSharing: json["isAllowSharing"],
        isAllowDuet: json["isAllowDuet"],
        isAllowComment: json["isAllowComment"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        string: json["string"],
        voteStatus: json["vote_status"],
        isSelf: json["is_self"],
        commentCount: json["comment_count"],
        likeStatus: json["like_status"],
        followStatus: json["follow_status"],
        auditionId: json["audition_id"],
        image: json["image"],
        isBoosted: json["isBoosted"],
        votes: json["votes"] == null
            ? []
            : List<Vote>.from(json["votes"]!.map((x) => Vote.fromJson(x))),
        isSaved: json["isSaved"],
        songId: json["songId"],
        song: json["song"] == null ? null : Song.fromJson(json["song"]),
      );
}

class Comment {
  final String? userId;
  final String? comment;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Comment({
    this.userId,
    this.comment,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        userId: json["user_id"],
        comment: json["comment"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}

class Song {
  final String? id;
  final String? title;
  final String? track;
  final String? trackAacFormat;
  final String? subtitle;
  final String? categoryId;
  final String? file;
  final String? image;
  final String? userid;
  final bool? byUser;
  final bool? isTrend;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserDetails? userDetails;

  Song({
    this.id,
    this.title,
    this.track,
    this.trackAacFormat,
    this.subtitle,
    this.categoryId,
    this.file,
    this.image,
    this.userid,
    this.byUser,
    this.isTrend,
    this.createdAt,
    this.updatedAt,
    this.userDetails,
  });

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["_id"],
        title: json["title"],
        track: json["track"],
        trackAacFormat: json["track_aac_format"],
        subtitle: json["subtitle"],
        categoryId: json["categoryId"],
        file: json["file"],
        image: json["Image"],
        userid: json["userid"],
        byUser: json["byUser"],
        isTrend: json["isTrend"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userDetails: json["userDetails"] == null
            ? null
            : UserDetails.fromJson(json["userDetails"]),
      );
}

class UserDetails {
  final String? id;
  final String? image;
  final String? auditionId;

  UserDetails({
    this.id,
    this.image,
    this.auditionId,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        id: json["_id"],
        image: json["image"],
        auditionId: json["audition_id"],
      );
}

class Vote {
  final String? id;
  final String? likeCategory;
  final String? emoji;
  final String? vote;
  final int? v;
  final int? uservotes;

  Vote({
    this.id,
    this.likeCategory,
    this.emoji,
    this.vote,
    this.v,
    this.uservotes,
  });

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        id: json["_id"],
        likeCategory: json["like_category"],
        emoji: json["emoji"],
        vote: json["vote"],
        v: json["__v"],
        uservotes: json["uservotes"],
      );
}

class PostComments {
  final String? userId;
  final String? comment;
  final String? createdAt;
  final String? auditionid;
  final String? commentBy;
  final String? commentId;
  final String? postId;
  final String? userImage;

  PostComments({
    this.userId,
    this.comment,
    this.createdAt,
    this.auditionid,
    this.commentBy,
    this.commentId,
    this.postId,
    this.userImage,
  });

  factory PostComments.fromMap(Map<String, dynamic> json) => PostComments(
        userId: json["user_id"],
        comment: json["comment"],
        auditionid: json["auditionid"],
        createdAt: json["created_at"],
        commentBy: json["comment_by"],
        commentId: json["comment_id"],
        postId: json["post_id"],
        userImage: json["userimage"],
      );
}
