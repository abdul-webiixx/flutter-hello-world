// To parse this JSON data, do
//
//     final upcomingLiveClassesModel = upcomingLiveClassesModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';

UpcomingLiveClassesModel upcomingLiveClassesModelFromJson(String str) => UpcomingLiveClassesModel.fromJson(json.decode(str));

String upcomingLiveClassesModelToJson(UpcomingLiveClassesModel data) => json.encode(data.toJson());

class UpcomingLiveClassesModel {
  UpcomingLiveClassesModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.upcomingModel,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<UpcomingModel>? upcomingModel;
  RequestStatus requestStatus;

  factory UpcomingLiveClassesModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return UpcomingLiveClassesModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      upcomingModel: json["data"]!=null ?
      List<UpcomingModel>.from(json["data"].map((x) => UpcomingModel.fromJson(x))) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": upcomingModel!=null ?
    List<dynamic>.from(upcomingModel!.map((x) => x.toJson())) : null,
  };
}

class UpcomingModel {
  UpcomingModel({
    this.name,
    this.startTime,
    this.endTime,
    this.date,
    this.month,
    this.packageId,
    this.status,
    this.icon,
    this.serviceName,
    this.serviceNameType,
    this.startMeetingUrl,
    this.meetingId,
    this.meetingPassword,
    this.hostEmail,
    this.hostId,
  });

  final String? name;
  final String? startTime;
  final String? endTime;
  final String? date;
  final String? month;
  final int? packageId;
  final String? status;
  final String? icon;
  final String? serviceName;
  final String? serviceNameType;
  final String? startMeetingUrl;
  final String? meetingId;
  final String? meetingPassword;
  final String? hostEmail;
  final String? hostId;

  factory UpcomingModel.fromJson(Map<String, dynamic> json){

    return  UpcomingModel(
        name: json["name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        date: json["date"],
        month: json["month"],
        packageId: json["package_id"],
        status: json["status"],
        icon:json["icon"]!=null ? setStoragePath(imagePath: json["icon"]) : null,
        serviceName: json["service_name"],
        startMeetingUrl: json["start_meeting_url"],
        meetingId: json["meeting_id"],
        meetingPassword: json["password"],
        serviceNameType: json["service_type_name"],
        hostEmail: json["host_email"],
        hostId: json["host_id"]);

  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "start_time": startTime,
    "end_time": endTime,
    "date": date,
    "month": month,
    "package_id": packageId,
    "status": status,
    "icon":icon,
    "service_type_name":serviceNameType,
    "service_name":serviceName,
    "start_meeting_url":startMeetingUrl,
    "meeting_id":meetingId,
    "password":meetingPassword,
    "host_id":hostId,
    "host_email":hostEmail
  };
}
