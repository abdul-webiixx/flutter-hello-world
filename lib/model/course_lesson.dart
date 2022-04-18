// To parse this JSON data, do
//
//     final courseLessonModel = courseLessonModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';

import 'course_information.dart';
import 'link.dart';

CourseLessonPackageModel courseLessonPackageModelFromJson(String str) => CourseLessonPackageModel.fromJson(json.decode(str));

String courseLessonPackageModelToJson(CourseLessonPackageModel data) => json.encode(data.toJson());

class CourseLessonPackageModel {
  CourseLessonPackageModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.courseInformation,
    this.courseLessonPackageData,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final CourseInformation? courseInformation;
  final CourseLessonPackageData? courseLessonPackageData;
  RequestStatus requestStatus;

  factory CourseLessonPackageModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null ){
      homeStoragePath= json["storage_path"];
    }
    return CourseLessonPackageModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      courseInformation: json["course_information"]!=null ?
      CourseInformation.fromJson(json["course_information"]) : null,
      courseLessonPackageData: json["data"]!=null ?
      CourseLessonPackageData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "course_information": courseInformation!=null ?
    courseInformation!.toJson() : null,
    "data":courseLessonPackageData!=null ?
    courseLessonPackageData!.toJson() : null,
  };
}

class CourseLessonPackageData {
  CourseLessonPackageData({
    this.currentPage,
    this.courseLessonPackageDetails,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int? currentPage;
  final List<CourseLessonPackageDetails>? courseLessonPackageDetails;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory CourseLessonPackageData.fromJson(Map<String, dynamic> json) => CourseLessonPackageData(
    currentPage: json["current_page"],
    courseLessonPackageDetails: json["data"]!=null ?
    List<CourseLessonPackageDetails>.from(json["data"].map((x) => CourseLessonPackageDetails.fromJson(x))): null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links:json["links"]!=null ?
    List<Link>.from(json["links"].map((x) => Link.fromJson(x))) :null,
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": courseLessonPackageDetails!=null ?
    List<dynamic>.from(courseLessonPackageDetails!.map((x) => x.toJson())) : null,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links!=null ?
    List<dynamic>.from(links!.map((x) => x.toJson())): null,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class CourseLessonPackageDetails {
  CourseLessonPackageDetails({
    this.id,
    this.choreographyId,
    this.lessonId,
    this.courseId,
    this.packageId,
    this.title,
    this.previewLesson,
    this.description,
    this.videoId,
    this.subscription,
    this.thumbnail
  });

  final int? id;
  final int? choreographyId;
  final int? lessonId;
  final int? courseId;
  final int? packageId;
  final String? title;
  final int? previewLesson;
  final String? description;
  final String? videoId;
  final String? thumbnail;
  final dynamic subscription;

  factory CourseLessonPackageDetails.fromJson(Map<String, dynamic> json) => CourseLessonPackageDetails(
      id: json["id"],
      choreographyId: json["choreography_id"],
    lessonId: json["lesson_id"],
    courseId: json["course_id"],
    packageId: json["package_id"],
    title: json["title"],
    previewLesson: json["preview_lesson"],
    description: json["description"],
    videoId: json["video_id"],
    subscription: json["subscription"],
    thumbnail:json["thumbnail"]
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "choreography_id": choreographyId,
    "lesson_id": lessonId,
    "course_id": courseId,
    "package_id": packageId,
    "title": title,
    "preview_lesson": previewLesson,
    "description": description,
    "video_id": videoId,
    "subscription": subscription,
    "thumbnail":thumbnail
  };
}

