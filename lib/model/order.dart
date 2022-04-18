// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.status,
    this.success,
    this.message,
    this.storagePath,
    this.orderDetails,
    this.requestStatus = RequestStatus.initial,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  late RequestStatus requestStatus;
  final OrderDetails? orderDetails;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    orderDetails: json["data"]!=null ? OrderDetails.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": orderDetails!=null ? orderDetails!.toJson(): null,
  };
}

class OrderDetails {
  OrderDetails({
    this.userId,
    this.date,
    this.address1,
    this.address2,
    this.state,
    this.city,
    this.zip,
    this.orderSubTotal,
    this.orderTotal,
    this.tax,
    this.discount,
    this.orderStatus,
    this.createdBy,
    this.actorIp,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  final String? userId;
  final DateTime? date;
  final String? address1;
  final String? address2;
  final String? state;
  final String? city;
  final String? zip;
  final dynamic orderSubTotal;
  final dynamic orderTotal;
  final dynamic tax;
  final dynamic discount;
  final String? orderStatus;
  final dynamic createdBy;
  final String? actorIp;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    userId: json["user_id"].toString(),
    date: DateTime.parse(json["date"]),
    address1: json["address_1"],
    address2: json["address_2"],
    state: json["state"],
    city: json["city"],
    zip: json["zip"],
    orderSubTotal: json["order_sub_total"],
    orderTotal: json["order_total"],
    tax: json["tax"],
    discount: json["discount"],
    orderStatus: json["order_status"],
    createdBy: json["created_by"],
    actorIp: json["actor_ip"],
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]): null,
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) : null,
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "address_1": address1,
    "address_2": address2,
    "state": state,
    "city": city,
    "zip": zip,
    "order_sub_total": orderSubTotal,
    "order_total": orderTotal,
    "tax": tax,
    "discount": discount,
    "order_status": orderStatus,
    "created_by": createdBy,
    "actor_ip": actorIp,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
    "created_at": createdAt!=null?  createdAt!.toIso8601String(): null,
    "id": id,
  };
}
