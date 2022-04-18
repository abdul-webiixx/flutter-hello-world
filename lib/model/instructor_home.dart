// To parse this JSON data, do
//
//     final instructorHomeModel = instructorHomeModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/instructor_profile.dart';
import 'package:Zenith/model/upcoming.dart';

import 'join_class.dart';

InstructorHomeModel instructorHomeModelFromJson(String str) => InstructorHomeModel.fromJson(json.decode(str));

String instructorHomeModelToJson(InstructorHomeModel data) => json.encode(data.toJson());

class InstructorHomeModel {
  InstructorHomeModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.instructorData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final InstructorData? instructorData;
  RequestStatus requestStatus;

  factory InstructorHomeModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return InstructorHomeModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      instructorData: InstructorData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": instructorData!=null ? instructorData!.toJson() : null,
  };
}

class InstructorData {
  InstructorData({
    this.upcomingLiveClasses,
    this.todayLiveClasses,
    this.reviews,
    this.profileData,
    this.zoom,
    this.workshopClass
  });

  final List<UpcomingModel>? upcomingLiveClasses;
  final List<UpcomingModel>? todayLiveClasses;
  final List<UpcomingModel>? workshopClass;
  final List<ReviewData>? reviews;
  final Instructor? profileData;
  final Zoom? zoom;

  factory InstructorData.fromJson(Map<String, dynamic> json) => InstructorData(
    upcomingLiveClasses: json["upcoming_live_classes"]!=null ?
    List<UpcomingModel>.from(json["upcoming_live_classes"].map((x) => UpcomingModel.fromJson(x))) : null,
    todayLiveClasses: json["todays_live_classes"]!=null ?
    List<UpcomingModel>.from(json["todays_live_classes"].map((x) => UpcomingModel.fromJson(x))) : null,
      workshopClass: json["workshop"]!=null ?
      List<UpcomingModel>.from(json["workshop"].map((x) => UpcomingModel.fromJson(x))) : null,
      reviews: json["reviews"]!=null ?
    List<ReviewData>.from(json["reviews"].map((x) => ReviewData.fromJson(x))) : null,
    profileData: json["profile"]!=null ? Instructor.fromJson(json["profile"]) : null,
    zoom: json["zoom"]!=null ? Zoom.fromJson(json["zoom"]) : null

  );

  Map<String, dynamic> toJson() => {
    "upcoming_live_classes": List<dynamic>.from(upcomingLiveClasses!.map((x) => x.toJson())),
    "todays_live_classes": List<dynamic>.from(todayLiveClasses!.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "profile": profileData!.toJson(),
    "zoom":zoom!.toJson()
  };
}
class Zoom {
  Zoom({
    this.jwtToken,
    this.webJwtToken,
    this.userToken,
    this.accessToken,
  });

  final String? jwtToken;
  final String? webJwtToken;
  final String? userToken;
  final String? accessToken;

  factory Zoom.fromJson(Map<String, dynamic> json) => Zoom(
    jwtToken: json["jwt_token"],
    webJwtToken: json["web_jwt_token"],
    userToken: json["user_token"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "jwt_token": jwtToken,
    "web_jwt_token": webJwtToken,
    "user_token": userToken,
    "access_token": accessToken,
  };
}
