// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

InvoiceModel invoiceModelFromJson(String str) => InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  InvoiceModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.data,
    this.requestStatus = RequestStatus.initial
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final Data? data;
  RequestStatus requestStatus;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    data: json["data"]!=null ? Data.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.link,
  });

  final String? link;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    link: json["link"],
  );

  Map<String, dynamic> toJson() => {
    "link": link,
  };
}
