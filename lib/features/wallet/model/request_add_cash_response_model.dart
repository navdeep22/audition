// To parse this JSON data, do
//
//     final requestAddCashResponseModel = requestAddCashResponseModelFromJson(jsonString);

import 'dart:convert';

RequestAddCashResponseModel requestAddCashResponseModelFromJson(String str) =>
    RequestAddCashResponseModel.fromJson(json.decode(str));

class RequestAddCashResponseModel {
  bool? status;
  String? message;
  RequestAddCashModel? data;

  RequestAddCashResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory RequestAddCashResponseModel.fromJson(Map<String, dynamic> json) =>
      RequestAddCashResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : RequestAddCashModel.fromJson(json["data"]),
      );
}

class RequestAddCashModel {
  String? orderid;
  String? translationId;

  RequestAddCashModel({
    this.orderid,
    this.translationId,
  });

  factory RequestAddCashModel.fromJson(Map<String, dynamic> json) =>
      RequestAddCashModel(
        orderid: json["orderid"],
        translationId: json["translationId"],
      );
}
