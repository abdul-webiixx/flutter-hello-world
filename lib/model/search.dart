// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.searchData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<SearchData>? searchData;
  RequestStatus requestStatus;

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return SearchModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      searchData: json["data"]!=null ? List<SearchData>.from(json["data"].map((x) => SearchData.fromJson(x))) :null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": List<dynamic>.from(searchData!.map((x) => x.toJson())),
  };
}

class SearchData {
  SearchData({
    this.id,
    this.name,
    this.productType,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.parentId,
    this.image,
    this.desc
  });

  final int? id;
  final String? name;
  final String? desc;
  final int? productType;
  final int? productId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? parentId;
  final String? image;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    id: json["id"],
    name: json["name"],
    productType: json["product_type"],
    productId: json["product_id"],
    desc: json["description"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    image: json["image"]!=null ? setStoragePath(imagePath: json["image"]): null ,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_type": productType,
    "product_id": productId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "parent_id": parentId == null ? null : parentId,
    "image": image,
    "description":desc
  };
}
