// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/comment_details.dart';
import 'package:Zenith/model/course_information.dart';
import 'package:Zenith/utils/enum.dart';

import 'link.dart';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.status,
    this.success,
    this.message,
    this.storagePath,
    this.courseInformation,
    this.commentData,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final CourseInformation? courseInformation;
  final CommentData? commentData;
  RequestStatus requestStatus;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return CommentModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      courseInformation: json["course_information"]!=null ? json["course_information"] : null,
      commentData: json["data"]!=null ? CommentData.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "course_information": courseInformation !=null ? commentData!.toJson() : null,
    "data": commentData!=null ? commentData!.toJson() : null,
  };
}

class CommentData {
  CommentData({
    this.currentPage,
    this.commentDetails,
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
  final List<Comment>? commentDetails;
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

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
    currentPage: json["current_page"],
    commentDetails: json["data"]!=null ? List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))): null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": commentDetails!=null ?
    List<dynamic>.from(commentDetails!.map((x) => x.toJson())): null,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links!=null ? List<dynamic>.from(links!.map((x) => x.toJson())) : null,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}


