// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/link.dart';

CourseModel courseModelFromJson(String str) => CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  CourseModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.courseInformation,
    this.courseData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final dynamic courseInformation;
  final CourseData? courseData;
  RequestStatus requestStatus;

  factory CourseModel.fromJson(Map<String, dynamic> json){
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return  CourseModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      courseInformation: json["course_information"],
      courseData: json["data"]!=null ?  CourseData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "course_information": courseInformation,
    "data": courseData!=null ? courseData!.toJson() : null,
  };
}

class CourseData {
  CourseData({
    this.currentPage,
    this.courseDetails,
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
  final List<CourseDetails>? courseDetails;
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

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
    currentPage: json["current_page"],
    courseDetails: List<CourseDetails>.from(json["data"].map((x) => CourseDetails.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"]!=null ? List<Link>.from(json["links"].map((x) => Link.fromJson(x))) : null,
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(courseDetails!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class CourseDetails {
  CourseDetails({
    this.title,
    this.id,
    this.featuredImage,
    this.lessons,
    this.subscriptionStatus,
    this.courseId,
    this.instructorId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.image,
    this.libraryId,
  });

  final String? title;
  final int? id;
  final String? featuredImage;
  final int? lessons;
  final String? subscriptionStatus;
  final int? courseId;
  final int? instructorId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? description;
  final dynamic image;
  final String? libraryId;

  factory CourseDetails.fromJson(Map<String, dynamic> json) => CourseDetails(
    title: json["title"],
    id: json["id"],
    featuredImage: json["featured_image"]!=null ? setStoragePath(imagePath: json["featured_image"]) : null,
    lessons: json["lessons"],
    subscriptionStatus: json["subscription_status"],
    courseId: json["course_id"],
    instructorId: json["instructor_id"],
    status: json["status"],
    createdAt:json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    name: json["name"],
    description: json["description"],
    image: json["image"]!=null ? setStoragePath(imagePath: json["image"]) : null,
    libraryId: json["library_id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "featured_image": featuredImage,
    "lessons": lessons,
    "subscription_status":subscriptionStatus,
    "course_id": courseId,
    "instructor_id": instructorId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "name": name,
    "description": description,
    "image": image,
    "library_id": libraryId,
  };
}
