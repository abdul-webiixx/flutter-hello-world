// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'link.dart';

SubscriptionModel subscriptionModelFromJson(String str) => SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

class SubscriptionModel {
  SubscriptionModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.subscriptionDetails,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<SubscriptionDetails>? subscriptionDetails;

  RequestStatus requestStatus;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    subscriptionDetails: json["data"]!=null && json["data"] is List?
    List<SubscriptionDetails>.from(json["data"].map((x) => SubscriptionDetails.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": subscriptionDetails!=null ? List<dynamic>.from(subscriptionDetails!.map((x) => x.toJson())): null,
  };
}

class SubscriptionData {
  SubscriptionData({
    this.currentPage,
    this.subscriptionDetails,
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
  final List<SubscriptionDetails>? subscriptionDetails;
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

  factory SubscriptionData.fromJson(Map<String, dynamic> json) => SubscriptionData(
    currentPage: json["current_page"],
    subscriptionDetails: json["data"]!=null ?
    List<SubscriptionDetails>.from(json["data"].map((x) => SubscriptionDetails.fromJson(x))): null,
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"]!=null ?
    List<Link>.from(json["links"].map((x) => Link.fromJson(x))): null,
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": subscriptionDetails!=null ? List<dynamic>.from(subscriptionDetails!.map((x) => x.toJson())): null,
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

class SubscriptionDetails {
  SubscriptionDetails({
    this.id,
    this.userId,
    this.name,
    this.productType,
    this.productId,
    this.startsAt,
    this.endsAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.featuresName,
    this.remainingClass
  });

  final int? id;
  final int? userId;
  final String? name;
  final int? productType;
  final int? productId;
  final DateTime? startsAt;
  final DateTime? endsAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final String? featuresName;
  final int? remainingClass;

  factory SubscriptionDetails.fromJson(Map<String, dynamic> json) => SubscriptionDetails(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    productType: json["product_type"],
    productId: json["product_id"],
    startsAt: json["starts_at"]!=null ? DateTime.parse(json["starts_at"]) : null,
    endsAt: json["ends_at"]!=null ? DateTime.parse(json["ends_at"]) : null,
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null ,
    status: json["status"],
    featuresName: json["features_name"],
      remainingClass:json["remaining_class"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "product_type": productType,
    "product_id": productId,
    "starts_at":startsAt!=null ?  startsAt!.toIso8601String() :null,
    "ends_at": endsAt!=null ? endsAt!.toIso8601String() : null,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "status": status,
    "features_name": featuresName,
    "remaining_class": remainingClass
  };
}
