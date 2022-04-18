import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'coupon_details.dart';

CouponModel couponModelFromJson(String str) => CouponModel.fromJson(json.decode(str));

String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    this.status,
    this.success = false,
    this.message,
    this.couponDetails,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final List<CouponDetails>? couponDetails;
  late RequestStatus requestStatus;


  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    couponDetails: json["data"]!=null ?
    List<CouponDetails>.from(json["data"].map((x) => CouponDetails.fromJson(x))): null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data":couponDetails!=null ?
    List<CouponDetails>.from(couponDetails!.map((x) => x.toJson())): null,
  };
}


