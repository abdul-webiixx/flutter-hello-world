// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/link.dart';
import 'package:Zenith/model/order.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    this.status,
    this.success=false,
    this.message,
    this.storagePath,
    this.orderHistoryData,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final OrderHistoryData? orderHistoryData;
  RequestStatus requestStatus;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    orderHistoryData: json["data"]!=null ? OrderHistoryData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": orderHistoryData!=null ? orderHistoryData!.toJson() : null,
  };
}

class OrderHistoryData {
  OrderHistoryData({
    this.currentPage,
    this.orderList,
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
  final List<OrderDetails>? orderList;
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

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) => OrderHistoryData(
    currentPage: json["current_page"],
    orderList: json["data"]!=null ? List<OrderDetails>.from(json["data"].map((x) => OrderDetails.fromJson(x)))
    :null,
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
    "data": orderList!=null ? List<dynamic>.from(orderList!.map((x) => x.toJson())): null,
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

