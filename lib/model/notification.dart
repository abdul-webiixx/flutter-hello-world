// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/constants/app_constants.dart';
import 'link.dart';
import 'package:Zenith/utils/enum.dart';


NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.success,
    this.message,
    this.notificationData,
    this.requestStatus = RequestStatus.loading
  });

  final Status? status;
  final dynamic success;
  final String? message;
  final NotificationData? notificationData;
  RequestStatus requestStatus;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"]!=null ? Status.fromJson(json["status"]) : null,
    success: json["success"],
    message: json["message"],
    notificationData: json["data"]!=null ? NotificationData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": notificationData!=null ? notificationData!.toJson() : null,
  };
}

class Status {
  Status({
    this.checked,
    this.unchecked,
  });

  final int? checked;
  final int? unchecked;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    checked: json["checked"],
    unchecked: json["unchecked"],
  );

  Map<String, dynamic> toJson() => {
    "checked": checked,
    "unchecked": unchecked,
  };
}



class NotificationDetails {
  NotificationDetails({
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.userId,
    this.avatar
  });

  int? id;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? type;
  dynamic userId;
  String? avatar;

  factory NotificationDetails.fromJson(Map<String, dynamic> json) =>
      NotificationDetails(
        id: json["id"],
        title: json["title"],
          description: json["description"],
        updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]): null,
        createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
        type: json["type"],
        userId: json["user_id"],
        avatar: json["avatar"]!=null ? setStoragePath(imagePath: json["avatar"]): null
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "created_at": createdAt!=null?  createdAt!.toIso8601String(): null,
    "type": type,
    "user_id": userId,
    "avatar":avatar
  };
}

class NotificationData {
  NotificationData({
    this.currentPage,
    this.notificationDetails,
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
  final List<NotificationDetails>? notificationDetails;
  final String? firstPageUrl;
  final dynamic from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final dynamic to;
  final int? total;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    currentPage: json["current_page"],
    notificationDetails: json["data"]!=null ?
    List<NotificationDetails>.from(json["data"].map((x) => NotificationDetails.fromJson(x))) :null,
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
    "data": notificationDetails!=null ?
    List<dynamic>.from(notificationDetails!.map((x) => x)) : null,
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links!=null ? List<dynamic>.from(links!.map((x) => x.toJson())): null,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}


