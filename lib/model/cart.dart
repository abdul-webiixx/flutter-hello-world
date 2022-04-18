// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);
import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'coupon_details.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  CartModel({
    this.status,
    this.success = false,
    this.message,
    this.cartData,
    this.requestStatus = RequestStatus.initial,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final CartData? cartData;
  late RequestStatus requestStatus;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    cartData: json["data"]!=null ? CartData.fromJson(json["data"]): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": cartData!=null ?  cartData!.toJson() : null,
  };
}

class CartData {
  CartData({
    this.cartDetails,
    this.cartItems,
    this.couponDetails,
    this.orderSummary,
  });

  final CartDetails? cartDetails;
  final List<CartItem>? cartItems;
  final CouponDetails? couponDetails;
  final OrderSummary? orderSummary;

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    cartDetails: json["cart_details"]!=null ?
    CartDetails.fromJson(json["cart_details"]): null,
    cartItems:json["cart_items"]!=null ?
    List<CartItem>.from(json["cart_items"].map((x) => CartItem.fromJson(x))) : null,
    couponDetails: json["coupon_details"]!=null ?
    CouponDetails.fromJson(json["coupon_details"]): null,
    orderSummary: json["order_summary"]!=null ?
    OrderSummary.fromJson(json["order_summary"]): null,
  );

  Map<String, dynamic> toJson() => {
    "cart_details":cartDetails!=null ? cartDetails!.toJson() : null,
    "cart_items": cartItems!=null ? List<dynamic>.from(cartItems!.map((x) => x.toJson())): null,
    "coupon_details":couponDetails!.toJson(),
    "order_summary": orderSummary!.toJson(),
  };
}

class CartDetails {
  CartDetails({
    this.id,
    this.key,
    this.userId,
    this.couponCode,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? key;
  final int? userId;
  final dynamic couponCode;
  final String? status;
  final dynamic deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
    id: json["id"],
    key: json["key"],
    userId: json["user_id"],
    couponCode: json["coupon_code"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt:json["created_at"]!=null ?  DateTime.parse(json["created_at"]): null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "user_id": userId,
    "coupon_code": couponCode,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
  };
}

class CartItem {
  CartItem({
    this.productName,
    this.price,
    this.quantity,
    this.cartItemId,
    this.description,
    this.productId,
    this.productType
  });

  final String? productName;
  final int? price;
  final int? quantity;
  final int? cartItemId;
  final String? description;
  final int? productId;
  final String? productType;


  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    productName: json["product_name"],
    price: json["price"],
    quantity: json["quantity"],
    cartItemId: json["cart_item_id"],
    description: json["description"],
    productId: json["product_id"],
    productType: json["product_type"]
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
    "price": price,
    "quantity": quantity,
    "cart_item_id": cartItemId,
    "description":description,
    "product_id":productId,
    "product_type":productType
  };
}

class OrderSummary {
  OrderSummary({
    this.subTotal,
    this.discount,
    this.tax,
    this.total,
  });

  final dynamic subTotal;
  final dynamic discount;
  final dynamic tax;
  final dynamic total;

  factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
    subTotal: json["sub_total"],
    discount: json["discount"],
    tax: json["tax"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "sub_total": subTotal,
    "discount": discount,
    "tax": tax,
    "total": total,
  };
}
