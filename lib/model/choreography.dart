// To parse this JSON data, do
//
//     final instructorChoreographyModel = instructorChoreographyModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/utils/enum.dart';

InstructorChoreographyModel instructorChoreographyModelFromJson(String str) => InstructorChoreographyModel.fromJson(json.decode(str));

String instructorChoreographyModelToJson(InstructorChoreographyModel data) => json.encode(data.toJson());

class InstructorChoreographyModel {
  InstructorChoreographyModel({
    this.status,
    this.success,
    this.message,
    this.storagePath,
    this.choreographyData,
    this.requestStatus= RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<ChoreographyData>? choreographyData;
  RequestStatus requestStatus;
  factory InstructorChoreographyModel.fromJson(Map<String, dynamic> json) => InstructorChoreographyModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    choreographyData: json["data"]!=null ?
    List<ChoreographyData>.from(json["data"].map((x) => ChoreographyData.fromJson(x))) : null
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data":choreographyData!=null ?  List<dynamic>.from(choreographyData!.map((x) => x.toJson())) : null,
  };
}

class ChoreographyData {
  ChoreographyData({
    this.id,
    this.courseId,
    this.instructorId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.image,
    this.libraryId,
    this.courseName,
  });

  final int? id;
  final int? courseId;
  final int? instructorId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? description;
  final dynamic image;
  final String? libraryId;
  final String? courseName;

  factory ChoreographyData.fromJson(Map<String, dynamic> json) => ChoreographyData(
    id: json["id"],
    courseId: json["course_id"],
    instructorId: json["instructor_id"],
    status: json["status"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    name: json["name"],
    description: json["description"],
    image: json["image"],
    libraryId: json["library_id"],
    courseName: json["course_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "instructor_id": instructorId,
    "status": status,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "name": name,
    "description": description,
    "image": image,
    "library_id": libraryId,
    "course_name": courseName,
  };
}
