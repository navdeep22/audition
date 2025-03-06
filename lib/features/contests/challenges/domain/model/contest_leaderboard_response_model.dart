// To parse this JSON data, do
//
//     final contestLeaderBoardResponse = contestLeaderBoardResponseFromJson(jsonString);

import 'dart:convert';

ContestLeaderBoardResponseModel contestLeaderBoardResponseFromJson(
        String str) =>
    ContestLeaderBoardResponseModel.fromJson(json.decode(str));

class ContestLeaderBoardResponseModel {
  bool? success;
  String? message;
  List<ContestLeaderResponse>? data;

  ContestLeaderBoardResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory ContestLeaderBoardResponseModel.fromJson(Map<String, dynamic> json) =>
      ContestLeaderBoardResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ContestLeaderResponse>.from(
                json["data"]!.map((x) => ContestLeaderResponse.fromJson(x))),
      );
}

class ContestLeaderResponse {
  int? usernumber;
  String? joinleaugeid;
  String? videoid;
  String? joinVideosId;
  String? userid;
  String? name;
  String? auditionId;
  String? image;
  String? status;
  int? votes;

  ContestLeaderResponse({
    this.usernumber,
    this.joinleaugeid,
    this.videoid,
    this.joinVideosId,
    this.userid,
    this.name,
    this.auditionId,
    this.image,
    this.status,
    this.votes,
  });

  factory ContestLeaderResponse.fromJson(Map<String, dynamic> json) =>
      ContestLeaderResponse(
        usernumber: json["usernumber"],
        joinleaugeid: json["joinleaugeid"],
        videoid: json["videoid"],
        joinVideosId: json["joinVideosId"],
        userid: json["userid"],
        name: json["name"],
        auditionId: json["auditionId"],
        image: json["image"],
        status: json["status"],
        votes: json["votes"],
      );
}
