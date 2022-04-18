// To parse this JSON data, do
//
//     final offlineClassPackageModel = offlineClassPackageModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

import 'link.dart';

OfflineClassPackageModel offlineClassPackageModelFromJson(String str) => OfflineClassPackageModel.fromJson(json.decode(str));

String offlineClassPackageModelToJson(OfflineClassPackageModel data) => json.encode(data.toJson());

class OfflineClassPackageModel {
  OfflineClassPackageModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.productType,
    this.offlineClassPackageData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final int? productType;
  final OfflineClassPackageData? offlineClassPackageData;
  RequestStatus requestStatus;

  factory OfflineClassPackageModel.fromJson(Map<String, dynamic> json) => OfflineClassPackageModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    productType: json["product_type"],
    offlineClassPackageData: json["data"]!=null ? OfflineClassPackageData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "product_type": productType,
    "data": offlineClassPackageData!=null ? offlineClassPackageData!.toJson() : null,
  };
}

class OfflineClassPackageData {
  OfflineClassPackageData({
    this.currentPage,
    this.offlineClassPackageDetails,
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
  final List<OfflineClassPackageDetails>? offlineClassPackageDetails;
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

  factory OfflineClassPackageData.fromJson(Map<String, dynamic> json) => OfflineClassPackageData(
    currentPage: json["current_page"],
    offlineClassPackageDetails: json["data"]!=null ? List<OfflineClassPackageDetails>
        .from(json["data"].map((x) => OfflineClassPackageDetails.fromJson(x))) : null,
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
    "data": List<dynamic>.from(offlineClassPackageDetails!.map((x) => x.toJson())),
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

class OfflineClassPackageDetails {
  OfflineClassPackageDetails({
    this.id,
    this.duration,
    this.durationType,
    this.amount,
    this.discount,
    this.paymentTerms,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.description,
    this.isTaxable,
    this.taxClassId,
    this.instalment,
  });

  final int? id;
  final int? duration;
  final String? durationType;
  final int? amount;
  final int? discount;
  final String? paymentTerms;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final dynamic description;
  final int? isTaxable;
  final dynamic taxClassId;
  final int? instalment;

  factory OfflineClassPackageDetails.fromJson(Map<String, dynamic> json) => OfflineClassPackageDetails(
    id: json["id"],
    duration: json["duration"],
    durationType: json["duration_type"],
    amount: json["amount"],
    discount: json["discount"],
    paymentTerms: json["payment_terms"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    name: json["name"],
    description: json["description"],
    isTaxable: json["is_taxable"],
    taxClassId: json["tax_class_id"],
    instalment: json["instalment"] == null ? null : json["instalment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "duration": duration,
    "duration_type": durationType,
    "amount": amount,
    "discount": discount,
    "payment_terms": paymentTerms,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "name": name,
    "description": description,
    "is_taxable": isTaxable,
    "tax_class_id": taxClassId,
    "instalment": instalment == null ? null : instalment,
  };
}
