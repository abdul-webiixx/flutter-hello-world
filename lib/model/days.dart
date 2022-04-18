// To parse this JSON data, do
//
//     final daysModel = daysModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/utils/enum.dart';
import 'package:http/http.dart';

DaysModel daysModelFromJson(String str) => DaysModel.fromJson(json.decode(str));

String daysModelToJson(DaysModel data) => json.encode(data.toJson());

class DaysModel {
  DaysModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.daysData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<DaysData>? daysData;
  RequestStatus requestStatus;

  factory DaysModel.fromJson(Map<String, dynamic> json) => DaysModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    daysData: List<DaysData>.from(json["data"].map((x) => DaysData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": List<dynamic>.from(daysData!.map((x) => x.toJson())),
  };
}

class DaysData {
  DaysData({
    this.id,
    this.packageId,
    this.day,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? packageId;
  final String? day;
  final String? startTime;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DaysData.fromJson(Map<String, dynamic> json) => DaysData(
    id: json["id"],
    packageId: json["package_id"],
    day: json["day"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    createdAt: json["created_at"]!=null ?
    DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ?
    DateTime.parse(json["updated_at"]): null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_id": packageId,
    "day": day,
    "start_time": startTime,
    "end_time": endTime,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
