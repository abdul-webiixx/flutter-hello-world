// To parse this JSON data, do
//
//     final AuthKeyModel = AuthKeyModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

AuthKeyModel authKeyModelFromJson(String str) => AuthKeyModel.fromJson(json.decode(str));

String authKeyModelToJson(AuthKeyModel data) => json.encode(data.toJson());

class AuthKeyModel {
  AuthKeyModel({
    this.status,
    this.success = false,
    this.message,
    this.data,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final String? message;
  final dynamic success;
  final Data? data;
  late RequestStatus requestStatus;

  factory AuthKeyModel.fromJson(Map<String, dynamic> json) => AuthKeyModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.orderId,
    this.key,
  });

  int? orderId;
  String? key;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
    key: json["key"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "key": key,
  };
}