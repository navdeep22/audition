// To parse this JSON data, do
//
//     final bankResponseModel = bankResponseModelFromJson(jsonString);

import 'dart:convert';

BankResponseModel bankResponseModelFromJson(String str) =>
    BankResponseModel.fromJson(json.decode(str));

class BankResponseModel {
  String? message;
  bool? status;
  BankModel? data;

  BankResponseModel({
    this.message,
    this.status,
    this.data,
  });

  factory BankResponseModel.fromJson(Map<String, dynamic> json) =>
      BankResponseModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : BankModel.fromJson(json["data"]),
      );
}

class BankModel {
  bool? status;
  String? accountholdername;
  String? accno;
  String? ifsc;
  String? bankname;
  String? bankbranch;
  String? state;
  String? comment;
  String? image;
  String? imagetype;

  BankModel({
    this.status,
    this.accountholdername,
    this.accno,
    this.ifsc,
    this.bankname,
    this.bankbranch,
    this.state,
    this.comment,
    this.image,
    this.imagetype,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        status: json["status"],
        accountholdername: json["accountholdername"],
        accno: json["accno"],
        ifsc: json["ifsc"],
        bankname: json["bankname"],
        bankbranch: json["bankbranch"],
        state: json["state"],
        comment: json["comment"],
        image: json["image"],
        imagetype: json["imagetype"],
      );
}
