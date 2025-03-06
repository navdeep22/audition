// To parse this JSON data, do
//
//     final contestDetailResponse = contestDetailResponseFromJson(jsonString);

import 'dart:convert';

ContestDetailResponse contestDetailResponseFromJson(String str) =>
    ContestDetailResponse.fromJson(json.decode(str));

class ContestDetailResponse {
  bool? success;
  String? message;
  ContestDetailModel? data;

  ContestDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ContestDetailResponse.fromJson(Map<String, dynamic> json) =>
      ContestDetailResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : ContestDetailModel.fromJson(json["data"]),
      );
}

class ContestDetailModel {
  String? matchchallengeid;
  int? winningPercentage;
  int? entryfee;
  int? winAmount;
  String? contestType;
  int? maximumUser;
  int? joinedusers;
  String? contestName;
  int? confirmedChallenge;
  int? isRunning;
  int? isBonus;
  int? bonusPercentage;
  String? pricecardType;
  bool? isselected;
  String? bonusDate;
  String? isselectedid;
  String? refercode;
  int? totalwinners;
  List<PriceCard>? priceCard;
  int? status;
  DateTime? startDate;
  DateTime? endDate;

  ContestDetailModel({
    this.matchchallengeid,
    this.winningPercentage,
    this.entryfee,
    this.winAmount,
    this.contestType,
    this.maximumUser,
    this.joinedusers,
    this.contestName,
    this.confirmedChallenge,
    this.isRunning,
    this.isBonus,
    this.bonusPercentage,
    this.pricecardType,
    this.isselected,
    this.bonusDate,
    this.isselectedid,
    this.refercode,
    this.totalwinners,
    this.priceCard,
    this.status,
    this.startDate,
    this.endDate,
  });

  factory ContestDetailModel.fromJson(Map<String, dynamic> json) =>
      ContestDetailModel(
        matchchallengeid: json["matchchallengeid"],
        winningPercentage: json["winning_percentage"],
        entryfee: json["entryfee"],
        winAmount: json["win_amount"],
        contestType: json["contest_type"],
        maximumUser: json["maximum_user"],
        joinedusers: json["joinedusers"],
        contestName: json["contest_name"],
        confirmedChallenge: json["confirmed_challenge"],
        isRunning: json["is_running"],
        isBonus: json["is_bonus"],
        bonusPercentage: json["bonus_percentage"],
        pricecardType: json["pricecard_type"],
        isselected: json["isselected"],
        bonusDate: json["bonus_date"],
        isselectedid: json["isselectedid"],
        refercode: json["refercode"],
        totalwinners: json["totalwinners"],
        priceCard: json["price_card"] == null
            ? []
            : List<PriceCard>.from(
                json["price_card"]!.map((x) => PriceCard.fromJson(x))),
        status: json["status"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
      );
}

class PriceCard {
  String? id;
  String? winners;
  String? total;
  String? distributionType;
  String? price;
  String? startPosition;

  PriceCard({
    this.id,
    this.winners,
    this.total,
    this.distributionType,
    this.price,
    this.startPosition,
  });

  factory PriceCard.fromJson(Map<String, dynamic> json) => PriceCard(
        id: json["id"],
        winners: json["winners"],
        total: json["total"],
        distributionType: json["distribution_type"],
        price: json["price"],
        startPosition: json["start_position"],
      );
}
