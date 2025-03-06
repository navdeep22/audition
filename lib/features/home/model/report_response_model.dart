// To parse this JSON data, do
//
//     final reportResponseModel = reportResponseModelFromJson(jsonString);

import 'dart:convert';

ReportResponseModel reportResponseModelFromJson(String str) =>
    ReportResponseModel.fromJson(json.decode(str));

class ReportResponseModel {
  String? message;
  bool? success;
  List<ReportModel>? data;

  ReportResponseModel({
    this.message,
    this.success,
    this.data,
  });

  factory ReportResponseModel.fromJson(Map<String, dynamic> json) =>
      ReportResponseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ReportModel>.from(
                json["data"]!.map((x) => ReportModel.fromJson(x))),
      );
}

class ReportModel {
  String? id;
  String? name;

  ReportModel({
    this.id,
    this.name,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["_id"],
        name: json["name"],
      );
}
