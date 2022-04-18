// To parse this JSON data, do
//
//     final courseLessonDetailsModel = courseLessonDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/video.dart';
import 'package:Zenith/utils/enum.dart';
import 'comment_details.dart';
import 'course_information.dart';
import 'other_information.dart';

CourseLessonDetailsModel courseLessonDetailsModelFromJson(String str) => CourseLessonDetailsModel.fromJson(json.decode(str));

String courseLessonDetailsModelToJson(CourseLessonDetailsModel data) => json.encode(data.toJson());

class CourseLessonDetailsModel {
  CourseLessonDetailsModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.courseInformation,
    this.videoModel,
    this.otherInformation,
    this.comments,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final CourseInformation? courseInformation;
  final VideoModel? videoModel;
  final OtherInformation? otherInformation;
  final List<Comment>? comments;
  RequestStatus requestStatus;

  factory CourseLessonDetailsModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null ){
      homeStoragePath= json["storage_path"];
    }
    return CourseLessonDetailsModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      courseInformation:json["course_information"]!=null ?
      CourseInformation.fromJson(json["course_information"]) : null,
      videoModel:json["data"]!=null ? VideoModel.fromJson(json["data"]) : null,
      otherInformation: json["other_information"]!=null ?
      OtherInformation.fromJson(json["other_information"]) : null,
      comments: json["comments"]!=null ?
      List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))): null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "course_information":courseInformation!=null ?  courseInformation!.toJson() : null,
    "data": videoModel!=null  ? videoModel!.toJson() : null,
    "other_information": otherInformation!=null ? otherInformation!.toJson() : null,
    "comments": comments!=null ? List<dynamic>.from(comments!.map((x) => x.toJson())) : null,
  };
}







