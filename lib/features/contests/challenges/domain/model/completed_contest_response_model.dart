// To parse this JSON data, do
//
//     final completedContestResponseModel = completedContestResponseModelFromJson(jsonString);

import 'dart:convert';

CompletedContestResponseModel completedContestResponseModelFromJson(
        String str) =>
    CompletedContestResponseModel.fromJson(json.decode(str));

class CompletedContestResponseModel {
  bool? success;
  String? message;
  CompletedContestData? data;

  CompletedContestResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory CompletedContestResponseModel.fromJson(Map<String, dynamic> json) =>
      CompletedContestResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : CompletedContestData.fromJson(json["data"]),
      );
}

class CompletedContestData {
  int? userrank;
  String? pdfname;
  List<Jointeam>? jointeams;

  CompletedContestData({
    this.userrank,
    this.pdfname,
    this.jointeams,
  });

  factory CompletedContestData.fromJson(Map<String, dynamic> json) =>
      CompletedContestData(
        userrank: json["userrank"],
        pdfname: json["pdfname"],
        jointeams: json["jointeams"] == null
            ? []
            : List<Jointeam>.from(
                json["jointeams"]!.map((x) => Jointeam.fromJson(x))),
      );
}

class Jointeam {
  String? userjoinid;
  String? userid;
  String? joinleaugeid;
  String? videoid;
  String? joinVideosId;
  int? vote;
  String? teamname;
  int? getcurrentrank;
  String? auditionId;
  String? status;
  String? image;
  int? userno;
  bool? isShow;
  String? winingamount;
  String? winningcrown;

  Jointeam({
    this.userjoinid,
    this.userid,
    this.joinleaugeid,
    this.videoid,
    this.joinVideosId,
    this.vote,
    this.teamname,
    this.getcurrentrank,
    this.auditionId,
    this.status,
    this.image,
    this.userno,
    this.isShow,
    this.winingamount,
    this.winningcrown,
  });

  factory Jointeam.fromJson(Map<String, dynamic> json) => Jointeam(
        userjoinid: json["userjoinid"],
        userid: json["userid"],
        joinleaugeid: json["joinleaugeid"],
        videoid: json["videoid"],
        joinVideosId: json["joinVideosId"],
        vote: json["vote"],
        teamname: json["teamname"],
        getcurrentrank: json["getcurrentrank"],
        auditionId: json["audition_id"],
        status: json["status"],
        image: json["image"],
        userno: json["userno"],
        isShow: json["is_show"],
        winingamount: json["winingamount"],
        winningcrown: json["winningcrown"],
      );
}
