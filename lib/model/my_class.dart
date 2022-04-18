// To parse this JSON data, do
//
//     final myClassModel = myClassModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/utils/enum.dart';

MyClassModel myClassModelFromJson(String str) => MyClassModel.fromJson(json.decode(str));

String myClassModelToJson(MyClassModel data) => json.encode(data.toJson());

class MyClassModel {
  MyClassModel({
    this.status,
    this.success,
    this.message,
    this.storagePath,
    this.myClassData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<MyClassData>? myClassData;
  RequestStatus requestStatus;

  factory MyClassModel.fromJson(Map<String, dynamic> json) => MyClassModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    myClassData: List<MyClassData>.from(json["data"].map((x) => MyClassData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": List<dynamic>.from(myClassData!.map((x) => x.toJson())),
  };
}

class MyClassData {
  MyClassData({
    this.id,
    this.packageId,
    this.batchId,
    this.weekDays,
    this.durationMonth,
    this.totalClasses,
    this.costPerClass,
    this.totalCost,
    this.totalHours,
    this.classDurationNote,
    this.additionalNote,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.className,
  });

  final int? id;
  final int? packageId;
  final int? batchId;
  final int? weekDays;
  final int? durationMonth;
  final int? totalClasses;
  final int? costPerClass;
  final int? totalCost;
  final int? totalHours;
  final String? classDurationNote;
  final String? additionalNote;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? className;

  factory MyClassData.fromJson(Map<String, dynamic> json) => MyClassData(
    id: json["id"],
    packageId: json["package_id"],
    batchId: json["batch_id"],
    weekDays: json["week_days"],
    durationMonth: json["duration_month"],
    totalClasses: json["total_classes"],
    costPerClass: json["cost_per_class"],
    totalCost: json["total_cost"],
    totalHours: json["total_hours"],
    classDurationNote: json["class_duration_note"],
    additionalNote: json["additional_note"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) :  null,
    className: json["class_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "package_id": packageId,
    "batch_id": batchId,
    "week_days": weekDays,
    "duration_month": durationMonth,
    "total_classes": totalClasses,
    "cost_per_class": costPerClass,
    "total_cost": totalCost,
    "total_hours": totalHours,
    "class_duration_note": classDurationNote,
    "additional_note": additionalNote,
    "deleted_at": deletedAt,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "class_name": className,
  };
}
