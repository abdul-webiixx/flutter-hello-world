// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/link.dart';
import 'package:Zenith/utils/enum.dart';


ClassModel classModelFromJson(String str) => ClassModel.fromJson(json.decode(str));

String classModelToJson(ClassModel data) => json.encode(data.toJson());

class ClassModel {
  ClassModel({
    this.status,
    this.success = false,
    this.message,
    this.classPage,
    this.storagePath,
    this.requestStatus = RequestStatus.initial,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final Class? classPage;
  final String? storagePath;
  late RequestStatus requestStatus;


  factory ClassModel.fromJson(Map<String, dynamic> json){
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
   return  ClassModel(
     status: json["status"],
     success: json["success"],
     message: json["message"],
     storagePath: json["storage_path"],
     classPage:json["data"]!=null ?  Class.fromJson(json["data"]) : null,
   );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": classPage!=null ?  classPage!.toJson() : null,
  };
}

class Class {
  Class({
    this.currentPage,
    this.singleClass,
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
  final List<SingleClass>? singleClass;
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

  factory Class.fromJson(Map<String, dynamic> json) {

  return  Class(
      currentPage: json["current_page"],
      singleClass: json["data"]!=null ?
      List<SingleClass>.from(json["data"].map((x) => SingleClass.fromJson(x))) : null,
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
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": singleClass!=null ?
    List<dynamic>.from(singleClass!.map((x) => x.toJson())): null,
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

class SingleClass {
  SingleClass({
    this.id,
    this.name = "",
    this.serviceId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.description = "",
    this.icon = "",
    this.type,
    this.avatar
  });

  final int? id;
  final String name;
  final int? serviceId;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String description;
  final String? icon;
  final String? avatar;
  final String? type;


  factory SingleClass.fromJson(Map<String, dynamic> json) => SingleClass(
    id: json["id"],
    name: json["name"]!=null ? json["name"] : "",
    serviceId:json["service_id"],
    deletedAt: json["deleted_at"],
    avatar: json["avatar"],
    createdAt:json["created_at"]!=null ?  DateTime.parse(json["created_at"]) :null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    description: json["description"]!=null ? json["description"] : "",
    icon: json["icon"]!=null ? setStoragePath(imagePath: json["icon"]) : null,
    type: json["type"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "service_id":serviceId,
    "deleted_at": deletedAt,
    "avatar": avatar,
    "created_at":createdAt!=null ?  createdAt!.toIso8601String() : null,
    "updated_at":updatedAt!=null ?  updatedAt!.toIso8601String(): null,
    "description":description,
    "icon":icon,
    "type":type
  };
}
