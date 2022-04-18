// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';

SignUpModel signUpFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel(
      {this.status,
      this.success = false,
      this.message,
      this.data,
      this.requestStatus = RequestStatus.initial});

  final int? status;
  final String? message;
  final dynamic success;
  final Data? data;
  late RequestStatus requestStatus;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        message: json["message"],
        success: json["success"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": data != null ? data!.toJson() : null,
      };
}

class Data {
  Data({
    this.userInformation,
    this.token,
  });

  final UserInformation? userInformation;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userInformation: json["user_information"] != null
            ? UserInformation.fromJson(json["user_information"])
            : null,
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user_information":
            userInformation != null ? userInformation!.toJson() : null,
        "token": token,
      };
}

class UserInformation {
  UserInformation(
      {this.id,
      this.roleId,
      this.name,
      this.mobile,
      this.email,
      this.avatar,
      this.emailVerifiedAt,
      this.settings,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.cardBrand,
      this.cardLastFour,
      this.trialEndsAt,
      this.zoomUserId,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.zip,
      this.dob,
      this.gstNo,
      this.gender});

  final int? id;
  final int? roleId;
  final String? name;
  final String? email;
  final String? avatar;
  final String? gstNo;
  final String? mobile;
  final dynamic emailVerifiedAt;
  final List<dynamic>? settings;
  final DateTime? createdAt;
  final dynamic dob;
  final DateTime? updatedAt;
  final dynamic stripeId;
  final dynamic cardBrand;
  final dynamic cardLastFour;
  final dynamic trialEndsAt;
  final dynamic zoomUserId;
  final dynamic address1;
  final dynamic address2;
  final dynamic city;
  final dynamic state;
  final dynamic zip;
  final dynamic gender;

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      UserInformation(
          id: json["id"],
          roleId: json["role_id"],
          name: json["name"],
          gstNo: json["gst_no"],
          email: json["email"],
          avatar: json["avatar"] != null
              ? setStoragePath(imagePath: json["avatar"])
              : null,
          emailVerifiedAt: json["email_verified_at"],
          settings: json["settings"] != null
              ? List<dynamic>.from(json["settings"].map((x) => x))
              : null,
          createdAt: json["created_at"] != null
              ? DateTime.parse(json["created_at"])
              : null,
          updatedAt: json["updated_at"] != null
              ? DateTime.parse(json["updated_at"])
              : null,
          stripeId: json["stripe_id"],
          cardBrand: json["card_brand"],
          cardLastFour: json["card_last_four"],
          trialEndsAt: json["trial_ends_at"],
          zoomUserId: json["zoom_user_id"],
          address1: json["address_1"],
          address2: json["address_2"],
          city: json["city"],
          state: json["state"],
          zip: json["zip"],
          dob: json["dob"],
          mobile: json["mobile"],
          gender: json["gender"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "avatar": avatar,
        "gst_no": gstNo,
        "email_verified_at": emailVerifiedAt,
        "settings": settings != null
            ? List<dynamic>.from(settings!.map((x) => x))
            : null,
        "created_at": createdAt != null ? createdAt!.toIso8601String() : null,
        "updated_at": updatedAt != null ? updatedAt!.toIso8601String() : null,
        "stripe_id": stripeId,
        "card_brand": cardBrand,
        "card_last_four": cardLastFour,
        "trial_ends_at": trialEndsAt,
        "zoom_user_id": zoomUserId,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "zip": zip,
        "dob": dob,
        "mobile": mobile,
        "gender": gender
      };
}
