// To parse this JSON data, do
//
//     final instructorStudenttModel = instructorStudenttModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/constants/app_constants.dart';

InstructorStudentModel instructorStudentModelFromJson(String str) => InstructorStudentModel.fromJson(json.decode(str));

String instructorStudentModelToJson(InstructorStudentModel data) => json.encode(data.toJson());

class InstructorStudentModel {
  InstructorStudentModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.studentData,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<StudentData>? studentData;

  factory InstructorStudentModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return InstructorStudentModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      studentData: json["data"]!=null ?
      List<StudentData>.from(json["data"].map((x) => StudentData.fromJson(x))): null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": List<dynamic>.from(studentData!.map((x) => x.toJson())),
  };
}

class StudentData {
  StudentData({
    this.userId,
    this.status,
    this.name,
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

  final int? userId;
  final String? status;
  final String? name;
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

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
    userId: json["user_id"],
    status: json["status"],
    name: json["name"],
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
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    className: json["class_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "status": status,
    "name": name,
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
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "class_name": className,
  };
}
