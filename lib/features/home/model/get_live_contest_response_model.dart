// To parse this JSON data, do
//
//     final getLiveContestResponseModel = getLiveContestResponseModelFromJson(jsonString);

import 'dart:convert';

GetLiveContestResponseModel getLiveContestResponseModelFromJson(String str) =>
    GetLiveContestResponseModel.fromJson(json.decode(str));

class GetLiveContestResponseModel {
  bool? success;
  String? message;
  List<LiveContestModel>? data;

  GetLiveContestResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetLiveContestResponseModel.fromJson(Map<String, dynamic> json) =>
      GetLiveContestResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<LiveContestModel>.from(
                json["data"]!.map((x) => LiveContestModel.fromJson(x))),
      );
}

class LiveContestModel {
  String? id;
  int? megaStatus;
  String? contestName;
  String? file;
  String? fileType;
  int? entryfee;
  int? winAmount;
  int? winningPercentage;
  int? maximumUser;
  int? minimumUser;
  String? contestType;
  DateTime? startDate;
  DateTime? endDate;
  int? confirmedChallenge;
  int? isBonus;
  int? isRunning;
  String? type;
  String? status;
  String? finalStatus;
  int? joinedusers;
  String? pricecardType;
  int? freez;
  String? bonusType;
  String? winnerDeclaredType;
  int? bonusPercentage;
  int? maxVideoTime;
  List<PriceCard>? priceCard;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? isJoined;
  int? totalWinners;

  LiveContestModel({
    this.id,
    this.megaStatus,
    this.contestName,
    this.file,
    this.fileType,
    this.entryfee,
    this.winAmount,
    this.winningPercentage,
    this.maximumUser,
    this.minimumUser,
    this.contestType,
    this.startDate,
    this.endDate,
    this.confirmedChallenge,
    this.isBonus,
    this.isRunning,
    this.type,
    this.status,
    this.finalStatus,
    this.joinedusers,
    this.pricecardType,
    this.freez,
    this.bonusType,
    this.winnerDeclaredType,
    this.bonusPercentage,
    this.maxVideoTime,
    this.priceCard,
    this.createdAt,
    this.updatedAt,
    this.isJoined,
    this.totalWinners,
  });

  factory LiveContestModel.fromJson(Map<String, dynamic> json) =>
      LiveContestModel(
        id: json["_id"],
        megaStatus: json["mega_status"],
        contestName: json["contest_name"],
        file: json["file"],
        fileType: json["fileType"],
        entryfee: json["entryfee"],
        winAmount: json["win_amount"],
        winningPercentage: json["winning_percentage"],
        maximumUser: json["maximum_user"],
        minimumUser: json["minimum_user"],
        contestType: json["contest_type"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        confirmedChallenge: json["confirmed_challenge"],
        isBonus: json["is_bonus"],
        isRunning: json["is_running"],
        type: json["type"],
        status: json["status"],
        finalStatus: json["final_status"],
        joinedusers: json["joinedusers"],
        pricecardType: json["pricecard_type"],
        freez: json["freez"],
        bonusType: json["bonus_type"],
        winnerDeclaredType: json["winner_declared_type"],
        bonusPercentage: json["bonus_percentage"],
        maxVideoTime: json["maxVideoTime"],
        priceCard: json["price_card"] == null
            ? []
            : List<PriceCard>.from(
                json["price_card"]!.map((x) => PriceCard.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        isJoined: json["isJoined"],
        totalWinners: json["total_winners"],
      );
}

class PriceCard {
  String? challengeId;
  String? winners;
  int? price;
  int? minPosition;
  int? maxPosition;
  int? total;
  String? type;
  String? id;

  PriceCard({
    this.challengeId,
    this.winners,
    this.price,
    this.minPosition,
    this.maxPosition,
    this.total,
    this.type,
    this.id,
  });

  factory PriceCard.fromJson(Map<String, dynamic> json) => PriceCard(
        challengeId: json["challengeId"],
        winners: json["winners"],
        price: json["price"],
        minPosition: json["min_position"],
        maxPosition: json["max_position"],
        total: json["total"],
        type: json["type"],
        id: json["_id"],
      );
}
