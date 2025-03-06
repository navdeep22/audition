// To parse this JSON data, do
//
//     final allTransactionResponseModel = allTransactionResponseModelFromJson(jsonString);

import 'dart:convert';

AllTransactionResponseModel allTransactionResponseModelFromJson(String str) =>
    AllTransactionResponseModel.fromJson(json.decode(str));

class AllTransactionResponseModel {
  bool? success;
  String? message;
  List<AllTransactionModel>? data;

  AllTransactionResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory AllTransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      AllTransactionResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AllTransactionModel>.from(
                json["data"]!.map((x) => AllTransactionModel.fromJson(x))),
      );
}

class AllTransactionModel {
  String? id;
  String? type;
  String? transactionId;
  int? amount;
  String? paymentstatus;
  DateTime? createdAt;

  AllTransactionModel({
    this.id,
    this.type,
    this.transactionId,
    this.amount,
    this.paymentstatus,
    this.createdAt,
  });

  factory AllTransactionModel.fromJson(Map<String, dynamic> json) =>
      AllTransactionModel(
        id: json["_id"],
        type: json["type"],
        transactionId: json["transaction_id"],
        amount: json["amount"],
        paymentstatus: json["paymentstatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );
}
