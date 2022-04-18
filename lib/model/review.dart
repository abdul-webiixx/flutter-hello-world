// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/link.dart';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.reviewData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final ReviewData? reviewData;
  RequestStatus requestStatus;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    reviewData:json["data"]!=null ?  ReviewData.fromJson(json["data"]): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": reviewData!=null ? reviewData!.toJson() : null,
  };
}

class ReviewData {
  ReviewData({
    this.currentPage,
    this.reviewDetails,
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
  final List<ReviewDetails>? reviewDetails;
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

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
    currentPage: json["current_page"],
    reviewDetails:json["data"]!=null ? List<ReviewDetails>.from(json["data"].map((x)
    => ReviewDetails.fromJson(x))) : null,
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
    "data": reviewDetails!=null ? List<dynamic>.from(reviewDetails!.map((x) => x.toJson())) : null,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links":links!=null ? List<dynamic>.from(links!.map((x) => x.toJson())) : null,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class ReviewDetails {
  ReviewDetails({
    this.id,
    this.userId,
    this.review,
    this.rating,
    this.product,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.name,
    this.avatar
  });

  final int? id;
  final int? userId;
  final String? review;
  final double? rating;
  final dynamic product;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final String? name;
  final String? avatar;

  factory ReviewDetails.fromJson(Map<String, dynamic> json) => ReviewDetails(
    id: json["id"],
    userId: json["user_id"],
    review: json["review"],
    rating: json["rating"].toDouble(),
    product: json["product"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    status: json["status"],
    name: json["name"],
    avatar: json["avatar"]!=null ? setStoragePath(imagePath: json["avatar"]) : null

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "review": review,
    "rating": rating,
    "product": product,
    "created_at":createdAt!=null ?  createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "status": status,
    "name": name,
    "avatar": avatar
  };
}

