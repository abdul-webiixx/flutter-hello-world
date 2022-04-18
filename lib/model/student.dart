// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/utils/enum.dart';

StudentModel studentModelFromJson(String str) => StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    this.status,
    this.success,
    this.message,
    this.storagePath,
    this.studentList,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<StudentData>? studentList;
  RequestStatus requestStatus;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    studentList:json["data"]!=null ?
    List<StudentData>.from(json["data"].map((x) => StudentData.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": List<dynamic>.from(studentList!.map((x) => x.toJson())),
  };
}

class StudentData {
  StudentData({
    this.userId,
    this.status,
    this.name,
    this.classId,
    this.packageId,
  });

  final int? userId;
  final String? status;
  final String? name;
  final int? classId;
  final int? packageId;

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
    userId: json["user_id"],
    status: json["status"],
    name: json["name"],
    classId: json["class_id"],
    packageId: json["package_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "status": status,
    "name": name,
    "class_id": classId,
    "package_id": packageId,
  };
}
