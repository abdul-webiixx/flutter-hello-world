// To parse this JSON data, do
//
//     final servicePackage = servicePackageFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

ServicePackage servicePackageFromJson(String str) => ServicePackage.fromJson(json.decode(str));

String servicePackageToJson(ServicePackage data) => json.encode(data.toJson());

class ServicePackage {
  ServicePackage({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.batchData,
    this.requestStatus = RequestStatus.initial,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final List<BatchData>? batchData;
  late RequestStatus requestStatus;



  factory ServicePackage.fromJson(Map<String, dynamic> json) => ServicePackage(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    batchData: json["data"]!=null ?
    List<BatchData>.from(json["data"].map((x) => BatchData.fromJson(x))):null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": List<dynamic>.from(batchData!.map((x) => x.toJson())),
  };
}

class BatchData {
  BatchData({
    this.batchName,
    this.dayList,
  });

  final String? batchName;
  final List<DayList>? dayList;

  factory BatchData.fromJson(Map<String, dynamic> json) => BatchData(
    batchName: json["batch_name"],
    dayList: List<DayList>.from(json["day_list"].map((x) => DayList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "batch_name": batchName,
    "day_list": List<dynamic>.from(dayList!.map((x) => x.toJson())),
  };
}

class DayList {
  DayList({
    this.dayName,
    this.monthList,
  });

  final String? dayName;
  final List<MonthList>? monthList;

  factory DayList.fromJson(Map<String, dynamic> json) => DayList(
    dayName: json["day_name"],
    monthList: List<MonthList>.from(json["month_list"].map((x) => MonthList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day_name": dayName,
    "month_list": List<dynamic>.from(monthList!.map((x) => x.toJson())),
  };
}

class MonthList {
  MonthList({
    this.monthName,
    this.packageId,
    this.days,
    this.totalClasses,
    this.totalCost,
    this.productType,
  });

  final String? monthName;
  final int? packageId;
  final int? days;
  final int? totalClasses;
  final int? totalCost;
  final int? productType;

  factory MonthList.fromJson(Map<String, dynamic> json) => MonthList(
    monthName: json["month_name"],
    packageId: json["package_id"],
    days: json["days"],
    totalClasses: json["total_classes"],
    totalCost: json["total_cost"],
    productType: json["product_type"],
  );

  Map<String, dynamic> toJson() => {
    "month_name": monthName,
    "package_id": packageId,
    "days": days,
    "total_classes": totalClasses,
    "total_cost": totalCost,
    "product_type": productType,
  };
}
