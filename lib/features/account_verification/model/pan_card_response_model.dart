// To parse this JSON data, do
//
//     final panCardResponseModel = panCardResponseModelFromJson(jsonString);

import 'dart:convert';

PanCardResponseModel panCardResponseModelFromJson(String str) =>
    PanCardResponseModel.fromJson(json.decode(str));

class PanCardResponseModel {
  String? message;
  bool? status;
  PanCardModel? data;

  PanCardResponseModel({
    this.message,
    this.status,
    this.data,
  });

  factory PanCardResponseModel.fromJson(Map<String, dynamic> json) =>
      PanCardResponseModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : PanCardModel.fromJson(json["data"]),
      );
}

class PanCardModel {
  bool? status;
  String? panname;
  String? pannumber;
  String? pandob;
  String? comment;
  String? image;
  String? imagetype;

  PanCardModel({
    this.status,
    this.panname,
    this.pannumber,
    this.pandob,
    this.comment,
    this.image,
    this.imagetype,
  });

  factory PanCardModel.fromJson(Map<String, dynamic> json) => PanCardModel(
        status: json["status"],
        panname: json["panname"],
        pannumber: json["pannumber"],
        pandob: json["pandob"],
        comment: json["comment"],
        image: json["image"],
        imagetype: json["imagetype"],
      );
}
