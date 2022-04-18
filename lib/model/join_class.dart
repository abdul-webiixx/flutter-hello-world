// To parse this JSON data, do
//
//     final joinClassModel = joinClassModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

JoinClassModel joinClassModelFromJson(String str) => JoinClassModel.fromJson(json.decode(str));

String joinClassModelToJson(JoinClassModel data) => json.encode(data.toJson());

class JoinClassModel {
  JoinClassModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.joinClassData,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final JoinClassData? joinClassData;
  RequestStatus requestStatus;

  factory JoinClassModel.fromJson(Map<String, dynamic> json) => JoinClassModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    joinClassData: json["data"]!=null ? JoinClassData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data":joinClassData!=null ? joinClassData!.toJson(): null,
  };
}

class JoinClassData {
  JoinClassData({
    this.id,
    this.userId,
    this.topic,
    this.type,
    this.startTime,
    this.duration,
    this.timezone,
    this.password,
    this.agenda,
    this.recurrenceType,
    this.repeatInterval,
    this.weeklyDays,
    this.monthlyDay,
    this.monthlyWeek,
    this.monthlyWeekDay,
    this.endTimes,
    this.endDateTime,
    this.hostVideo,
    this.participantVideo,
    this.cnMeeting,
    this.inMeeting,
    this.joinBeforeHost,
    this.muteUponEntry,
    this.watermark,
    this.usePmi,
    this.approvalType,
    this.registrationType,
    this.audio,
    this.autoRecording,
    this.enforceLogin,
    this.enforceLoginDomains,
    this.alternativeHosts,
    this.registrantsEmailNotification,
    this.createdAt,
    this.updatedAt,
    this.uuid,
    this.meetingId,
    this.hostId,
    this.hostEmail,
    this.status,
    this.startUrl,
    this.joinUrl,
    this.user,
    this.classType,
    this.service,
    this.serviceType,
    this.package,
    this.batch,
    this.packageItemId,
  });

  final int? id;
  final dynamic userId;
  final String? topic;
  final dynamic type;
  final dynamic startTime;
  final dynamic duration;
  final dynamic timezone;
  final dynamic password;
  final dynamic agenda;
  final dynamic recurrenceType;
  final dynamic repeatInterval;
  final dynamic weeklyDays;
  final dynamic monthlyDay;
  final dynamic monthlyWeek;
  final dynamic monthlyWeekDay;
  final dynamic endTimes;
  final dynamic endDateTime;
  final dynamic hostVideo;
  final dynamic participantVideo;
  final dynamic cnMeeting;
  final dynamic inMeeting;
  final dynamic joinBeforeHost;
  final dynamic muteUponEntry;
  final dynamic watermark;
  final dynamic usePmi;
  final dynamic approvalType;
  final dynamic registrationType;
  final dynamic audio;
  final String? autoRecording;
  final dynamic enforceLogin;
  final dynamic enforceLoginDomains;
  final dynamic alternativeHosts;
  final int? registrantsEmailNotification;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? uuid;
  final String? meetingId;
  final String? hostId;
  final String? hostEmail;
  final String? status;
  final String? startUrl;
  final String? joinUrl;
  final dynamic user;
  final dynamic classType;
  final dynamic service;
  final dynamic serviceType;
  final dynamic package;
  final dynamic batch;
  final int? packageItemId;

  factory JoinClassData.fromJson(Map<String, dynamic> json) => JoinClassData(
    id: json["id"],
    userId: json["user_id"],
    topic: json["topic"],
    type: json["type"],
    startTime: json["start_time"],
    duration: json["duration"],
    timezone: json["timezone"],
    password: json["password"],
    agenda: json["agenda"],
    recurrenceType: json["recurrence_type"],
    repeatInterval: json["repeat_interval"],
    weeklyDays: json["weekly_days"],
    monthlyDay: json["monthly_day"],
    monthlyWeek: json["monthly_week"],
    monthlyWeekDay: json["monthly_week_day"],
    endTimes: json["end_times"],
    endDateTime: json["end_date_time"],
    hostVideo: json["host_video"],
    participantVideo: json["participant_video"],
    cnMeeting: json["cn_meeting"],
    inMeeting: json["in_meeting"],
    joinBeforeHost: json["join_before_host"],
    muteUponEntry: json["mute_upon_entry"],
    watermark: json["watermark"],
    usePmi: json["use_pmi"],
    approvalType: json["approval_type"],
    registrationType: json["registration_type"],
    audio: json["audio"],
    autoRecording: json["auto_recording"],
    enforceLogin: json["enforce_login"],
    enforceLoginDomains: json["enforce_login_domains"],
    alternativeHosts: json["alternative_hosts"],
    registrantsEmailNotification: json["registrants_email_notification"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]): null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    uuid: json["uuid"],
    meetingId: json["meeting_id"],
    hostId: json["host_id"],
    hostEmail: json["host_email"],
    status: json["status"],
    startUrl: json["start_url"],
    joinUrl: json["join_url"],
    user: json["user"],
    classType: json["class_type"],
    service: json["service"],
    serviceType: json["service_type"],
    package: json["package"],
    batch: json["batch"],
    packageItemId: json["package_item_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "topic": topic,
    "type": type,
    "start_time": startTime,
    "duration": duration,
    "timezone": timezone,
    "password": password,
    "agenda": agenda,
    "recurrence_type": recurrenceType,
    "repeat_interval": repeatInterval,
    "weekly_days": weeklyDays,
    "monthly_day": monthlyDay,
    "monthly_week": monthlyWeek,
    "monthly_week_day": monthlyWeekDay,
    "end_times": endTimes,
    "end_date_time": endDateTime,
    "host_video": hostVideo,
    "participant_video": participantVideo,
    "cn_meeting": cnMeeting,
    "in_meeting": inMeeting,
    "join_before_host": joinBeforeHost,
    "mute_upon_entry": muteUponEntry,
    "watermark": watermark,
    "use_pmi": usePmi,
    "approval_type": approvalType,
    "registration_type": registrationType,
    "audio": audio,
    "auto_recording": autoRecording,
    "enforce_login": enforceLogin,
    "enforce_login_domains": enforceLoginDomains,
    "alternative_hosts": alternativeHosts,
    "registrants_email_notification": registrantsEmailNotification,
    "created_at":createdAt!=null ?  createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "uuid": uuid,
    "meeting_id": meetingId,
    "host_id": hostId,
    "host_email": hostEmail,
    "status": status,
    "start_url": startUrl,
    "join_url": joinUrl,
    "user": user,
    "class_type": classType,
    "service": service,
    "service_type": serviceType,
    "package": package,
    "batch": batch,
    "package_item_id": packageItemId,
  };
}
