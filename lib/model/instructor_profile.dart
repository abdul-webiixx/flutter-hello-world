// To parse this JSON data, do
//
//     final instructorProfileModel = instructorProfileModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';

import 'link.dart';

InstructorProfileModel instructorProfileModelFromJson(String str) => InstructorProfileModel.fromJson(json.decode(str));

String instructorProfileModelToJson(InstructorProfileModel data) => json.encode(data.toJson());

class InstructorProfileModel {
  InstructorProfileModel({
    this.profileData,
    this.reviews,
    this.message,
    this.status,
    this.success = false,
    this.requestStatus =RequestStatus.initial
  });

  final ProfileData? profileData;
  final Reviews? reviews;
  final String? message;
  final int? status;
  final dynamic success;
  RequestStatus requestStatus;

  factory InstructorProfileModel.fromJson(Map<String, dynamic> json) => InstructorProfileModel(
    profileData: json["data"]!=null ? ProfileData.fromJson(json["data"]) : null,
    reviews: json["reviews"]!=null ? Reviews.fromJson(json["reviews"]) : null,
    message: json["message"],
    status: json["status"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": profileData!.toJson(),
    "reviews": reviews!.toJson(),
    "message": message,
    "status": status,
    "success": success,
  };
}

class ProfileData {
  ProfileData({
    this.id,
    this.name,
    this.avatar,
    this.danceForms,
    this.totalRatings,
    this.classes,
  });

  final int? id;
  final String? name;
  final String? avatar;
  final String? danceForms;
  final dynamic totalRatings;
  final dynamic classes;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
    danceForms: json["dance_forms"],
    totalRatings: json["total_ratings"],
    classes: json["classes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
    "dance_forms": danceForms,
    "total_ratings": totalRatings,
    "classes": classes,
  };
}

class Reviews {
  Reviews({
    this.currentPage,
    this.data,
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
  final List<ReviewData>? data;
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

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
    currentPage: json["current_page"],
    data: json["data"]!=null ?
    List<ReviewData>.from(json["data"].map((x) => ReviewData.fromJson(x))) : null,
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
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
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

class ReviewData {
  ReviewData({
    this.id,
    this.userId,
    this.instructorId,
    this.review,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.name,
    this.avatar,
  });

  final int? id;
  final int? userId;
  final int? instructorId;
  final String? review;
  final dynamic rating;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final String? name;
  final String? avatar;

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
    id: json["id"],
    userId: json["user_id"],
    instructorId: json["instructor_id"],
    review: json["review"],
    rating: json["rating"].toDouble(),
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    status: json["status"],
    name: json["name"],
    avatar: json["avatar"]!=null ? setStoragePath(imagePath: json["avatar"]): null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "instructor_id": instructorId,
    "review": review,
    "rating": rating,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "status": status,
    "name": name,
    "avatar": avatar,
  };
}

