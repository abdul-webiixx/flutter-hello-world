// To parse this JSON data, do
//
//     final orderSummaryModel = orderSummaryModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

OrderSummaryModel orderSummaryModelFromJson(String str) => OrderSummaryModel.fromJson(json.decode(str));

String orderSummaryModelToJson(OrderSummaryModel data) => json.encode(data.toJson());

class OrderSummaryModel {
  OrderSummaryModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.orderSummaryData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final OrderSummaryData? orderSummaryData;
  RequestStatus requestStatus;

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) => OrderSummaryModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    orderSummaryData: json["data"]!=null ? OrderSummaryData.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": orderSummaryData!.toJson(),
  };
}

class OrderSummaryData {
  OrderSummaryData({
    this.orderPlacedDetails,
    this.orderItems,
  });

  final OrderPlacedDetails? orderPlacedDetails;
  final List<OrderItem>? orderItems;

  factory OrderSummaryData.fromJson(Map<String, dynamic> json) => OrderSummaryData(
    orderPlacedDetails: json["order_details"]!=null ?
    OrderPlacedDetails.fromJson(json["order_details"]) : null,
    orderItems: json["order_items"]!=null ?
    List<OrderItem>.from(json["order_items"].map((x) => OrderItem.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "order_details": orderPlacedDetails!.toJson(),
    "order_items": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
  };
}

class OrderPlacedDetails {
  OrderPlacedDetails({
    this.id,
    this.date,
    this.userId,
    this.orderSubTotal,
    this.orderTotal,
    this.orderStatus,
    this.actorIp,
    this.createdBy,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.address1,
    this.address2,
    this.state,
    this.city,
    this.zip,
    this.discount,
    this.tax,
    this.couponId,
  });

  final int? id;
  final DateTime? date;
  final int? userId;
  final dynamic orderSubTotal;
  final dynamic orderTotal;
  final String? orderStatus;
  final String? actorIp;
  final int? createdBy;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? address1;
  final String? address2;
  final String? state;
  final String? city;
  final String? zip;
  final dynamic discount;
  final dynamic tax;
  final dynamic couponId;

  factory OrderPlacedDetails.fromJson(Map<String, dynamic> json) => OrderPlacedDetails(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    userId: json["user_id"],
    orderSubTotal: json["order_sub_total"],
    orderTotal: json["order_total"],
    orderStatus: json["order_status"],
    actorIp: json["actor_ip"],
    createdBy: json["created_by"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]): null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    address1: json["address_1"],
    address2: json["address_2"],
    state: json["state"],
    city: json["city"],
    zip: json["zip"],
    discount: json["discount"],
    tax: json["tax"],
    couponId: json["coupon_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "user_id": userId,
    "order_sub_total": orderSubTotal,
    "order_total": orderTotal,
    "order_status": orderStatus,
    "actor_ip": actorIp,
    "created_by": createdBy,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "address_1": address1,
    "address_2": address2,
    "state": state,
    "city": city,
    "zip": zip,
    "discount": discount,
    "tax": tax,
    "coupon_id": couponId,
  };
}

class OrderItem {
  OrderItem({
    this.id,
    this.userId,
    this.orderId,
    this.productType,
    this.productId,
    this.productTitle,
    this.price,
    this.sellPrice,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.quantity,
    this.centre,
    this.taxPercentage,
    this.taxPrice,
  });

  final int? id;
  final int? userId;
  final int? orderId;
  final String? productType;
  final int? productId;
  final String? productTitle;
  final dynamic price;
  final dynamic sellPrice;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic type;
  final dynamic quantity;
  final dynamic centre;
  final dynamic taxPercentage;
  final dynamic taxPrice;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    productType: json["product_type"],
    productId: json["product_id"],
    productTitle: json["product_title"],
    price: json["price"],
    sellPrice: json["sell_price"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]): null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
    type: json["type"],
    quantity: json["quantity"],
    centre: json["centre"],
    taxPercentage: json["tax_percentage"],
    taxPrice: json["tax_price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "product_type": productType,
    "product_id": productId,
    "product_title": productTitle,
    "price": price,
    "sell_price": sellPrice,
    "deleted_at": deletedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "type": type,
    "quantity": quantity,
    "centre": centre,
    "tax_percentage": taxPercentage,
    "tax_price": taxPrice,
  };
}
