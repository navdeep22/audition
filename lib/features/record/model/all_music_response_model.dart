// To parse this JSON data, do
//
//     final allMusicUploadedResponseModel = allMusicUploadedResponseModelFromJson(jsonString);

import 'dart:convert';

AllMusicUploadedResponseModel allMusicUploadedResponseModelFromJson(
        String str) =>
    AllMusicUploadedResponseModel.fromJson(json.decode(str));

class AllMusicUploadedResponseModel {
  String? message;
  bool? success;
  List<MusicModel>? data;

  AllMusicUploadedResponseModel({
    this.message,
    this.success,
    this.data,
  });

  factory AllMusicUploadedResponseModel.fromJson(Map<String, dynamic> json) =>
      AllMusicUploadedResponseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<MusicModel>.from(
                json["data"]!.map((x) => MusicModel.fromJson(x))),
      );
}

class MusicModel {
  String? title;
  String? subtitle;
  String? datumImage;
  String? type;
  String? id;
  String? track;
  String? trackAacFormat;
  CategoryId? categoryId;
  String? file;
  String? image;
  String? userid;
  bool? byUser;
  bool? isTrend;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isFav;
  bool? isPlaying;

  MusicModel({
    this.title,
    this.subtitle,
    this.datumImage,
    this.type,
    this.id,
    this.track,
    this.trackAacFormat,
    this.categoryId,
    this.file,
    this.image,
    this.userid,
    this.byUser,
    this.isTrend,
    this.createdAt,
    this.updatedAt,
    this.isFav,
    this.isPlaying = false,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) => MusicModel(
        title: json["title"],
        subtitle: json["subtitle"],
        datumImage: json["image"],
        type: json["type"],
        id: json["_id"],
        track: json["track"],
        trackAacFormat: json["track_aac_format"],
        categoryId: json["categoryId"] == null
            ? null
            : CategoryId.fromJson(json["categoryId"]),
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
        isFav: json["isFav"],
      );
}

class CategoryId {
  String? id;
  String? title;
  String? image;
  String? subtitle;
  DateTime? createdAt;
  DateTime? updatedAt;

  CategoryId({
    this.id,
    this.title,
    this.image,
    this.subtitle,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        title: json["title"],
        image: json["image"],
        subtitle: json["subtitle"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
