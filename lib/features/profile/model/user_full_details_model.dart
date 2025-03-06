// To parse this JSON data, do
//
//     final userFullDetails = userFullDetailsFromJson(jsonString);

import 'dart:convert';

UserFullDetails userFullDetailsFromJson(String str) =>
    UserFullDetails.fromJson(json.decode(str));

class UserFullDetails {
  String? message;
  bool? success;
  UserData? data;

  UserFullDetails({
    this.message,
    this.success,
    this.data,
  });

  factory UserFullDetails.fromJson(Map<String, dynamic> json) =>
      UserFullDetails(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );
}

class UserData {
  String? id;
  int? unreadMsg;
  String? name;
  int? mobile;
  String? email;
  String? auditionId;
  int? followersCount;
  int? followingCount;
  String? bio;
  String? pincode;
  String? address;
  String? dob;
  String? dayOfBirth;
  String? monthOfBirth;
  String? yearOfBirth;
  String? gender;
  String? image;
  String? activationStatus;
  String? state;
  String? city;
  String? team;
  int? teamfreeze;
  String? referCode;
  String? totalbalance;
  String? totalwon;
  String? totalbonus;
  String? totalcheers;
  String? totalmints;
  int? walletamaount;
  int? verified;
  int? downloadapk;
  int? emailfreeze;
  int? mobilefreeze;
  int? mobileVerified;
  int? emailVerified;
  int? panVerified;
  int? bankVerified;
  int? statefreeze;
  int? dobfreeze;
  int? totalLike;
  bool? followStatus;

  UserData({
    this.id,
    this.unreadMsg,
    this.name,
    this.mobile,
    this.email,
    this.auditionId,
    this.followersCount,
    this.followingCount,
    this.bio,
    this.pincode,
    this.address,
    this.dob,
    this.dayOfBirth,
    this.monthOfBirth,
    this.yearOfBirth,
    this.gender,
    this.image,
    this.activationStatus,
    this.state,
    this.city,
    this.team,
    this.teamfreeze,
    this.referCode,
    this.totalbalance,
    this.totalwon,
    this.totalbonus,
    this.totalcheers,
    this.totalmints,
    this.walletamaount,
    this.verified,
    this.downloadapk,
    this.emailfreeze,
    this.mobilefreeze,
    this.mobileVerified,
    this.emailVerified,
    this.panVerified,
    this.bankVerified,
    this.statefreeze,
    this.dobfreeze,
    this.totalLike,
    this.followStatus,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        unreadMsg: json["unread_msg"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        auditionId: json["audition_id"],
        followersCount: json["followers_count"],
        followingCount: json["following_count"],
        bio: json["bio"],
        pincode: json["pincode"],
        address: json["address"],
        dob: json["dob"],
        dayOfBirth: json["DayOfBirth"],
        monthOfBirth: json["MonthOfBirth"],
        yearOfBirth: json["YearOfBirth"],
        gender: json["gender"],
        image: json["image"],
        activationStatus: json["activation_status"],
        state: json["state"],
        city: json["city"],
        team: json["team"],
        teamfreeze: json["teamfreeze"],
        referCode: json["refer_code"],
        totalbalance: json["totalbalance"],
        totalwon: json["totalwon"],
        totalbonus: json["totalbonus"],
        totalcheers: json["totalcheers"],
        totalmints: json["totalmints"],
        walletamaount: json["walletamaount"],
        verified: json["verified"],
        downloadapk: json["downloadapk"],
        emailfreeze: json["emailfreeze"],
        mobilefreeze: json["mobilefreeze"],
        mobileVerified: json["mobileVerified"],
        emailVerified: json["emailVerified"],
        panVerified: json["PanVerified"],
        bankVerified: json["BankVerified"],
        statefreeze: json["statefreeze"],
        dobfreeze: json["dobfreeze"],
        totalLike: json["totalLike"],
        followStatus: json["follow_status"],
      );
}

OtherUserResponseModel otherUserResponseModelFromJson(String str) =>
    OtherUserResponseModel.fromJson(json.decode(str));

class OtherUserResponseModel {
  String? message;
  bool? success;
  List<UserData>? data;

  OtherUserResponseModel({
    this.message,
    this.success,
    this.data,
  });

  factory OtherUserResponseModel.fromJson(Map<String, dynamic> json) =>
      OtherUserResponseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<UserData>.from(
                json["data"]!.map((x) => UserData.fromJson(x))),
      );
}
