// To parse this JSON data, do
//
//     final coursePackageModel = coursePackageModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'course_information.dart';
import 'link.dart';

CoursePackageModel coursePackageModelFromJson(String str) => CoursePackageModel.fromJson(json.decode(str));

String coursePackageModelToJson(CoursePackageModel data) => json.encode(data.toJson());

class CoursePackageModel {
  CoursePackageModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.courseInformation,
    this.requestStatus = RequestStatus.initial,
    this.coursePackageData,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final CourseInformation? courseInformation;
  RequestStatus requestStatus;
  final CoursePackageData? coursePackageData;

  factory CoursePackageModel.fromJson(Map<String, dynamic> json) => CoursePackageModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    courseInformation: json["course_information"]!=null ?
    CourseInformation.fromJson(json["course_information"]) : null,
    coursePackageData: json["data"]!=null ?
    CoursePackageData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "course_information": courseInformation!=null ?
    courseInformation!.toJson() : null,
    "data": coursePackageData!=null ? coursePackageData!.toJson() : null,
  };
}

class CoursePackageData {
  CoursePackageData({
    this.currentPage,
    this.coursePackageDetails,
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
  final List<CoursePackageDetails>? coursePackageDetails;
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

  factory CoursePackageData.fromJson(Map<String, dynamic> json) => CoursePackageData(
    currentPage: json["current_page"],
    coursePackageDetails: json["data"]!=null ?
    List<CoursePackageDetails>.from(json["data"].map((x) => CoursePackageDetails.fromJson(x))) : null,
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
    "data": coursePackageDetails!=null ?
    List<dynamic>.from(coursePackageDetails!.map((x) => x.toJson())): null,
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

class CoursePackageDetails {
  CoursePackageDetails({
    this.id,
    this.courseId,
    this.name,
    this.type,
    this.duration,
    this.price,
    this.sellPrice,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.productType,
  });

  final int? id;
  final int? courseId;
  final String? name;
  final String? type;
  final int? duration;
  final int? price;
  final double? sellPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic description;
  final int? productType;

  factory CoursePackageDetails.fromJson(Map<String, dynamic> json) => CoursePackageDetails(
    id: json["id"],
    courseId: json["course_id"],
    name: json["name"],
    type: json["type"],
    duration: json["duration"],
    price: json["price"],
    sellPrice: json["sell_price"].toDouble(),
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    description: json["description"],
    productType: json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course_id": courseId,
    "name": name,
    "type": type,
    "duration": duration,
    "price": price,
    "sell_price": sellPrice,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String(): null,
    "description": description,
    "product_type": productType,
  };
}

