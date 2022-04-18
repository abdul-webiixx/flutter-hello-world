// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    this.status,
    this.success = false,
    this.message,
    this.storagePath,
    this.privacyPolicyData,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final dynamic success;
  final String? message;
  final String? storagePath;
  final PrivacyPolicyData? privacyPolicyData;
  late RequestStatus requestStatus;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) => PrivacyPolicyModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    storagePath: json["storage_path"],
    privacyPolicyData: json["data"]!=null ? PrivacyPolicyData.fromJson(json["data"]) :null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "storage_path": storagePath,
    "data": privacyPolicyData!= null ? privacyPolicyData!.toJson() : null,
  };
}

class PrivacyPolicyData {
  PrivacyPolicyData({
    this.id,
    this.name,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PrivacyPolicyData.fromJson(Map<String, dynamic> json) => PrivacyPolicyData(
    id: json["id"],
    name: json["name"],
    content: json["content"],
    createdAt: json["created_at"]!=null ? DateTime.parse(json["created_at"]) :null,
    updatedAt: json["updated_at"]!=null ? DateTime.parse(json["updated_at"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "content": content,
    "created_at": createdAt!=null ? createdAt!.toIso8601String() : null,
    "updated_at": updatedAt!=null ? updatedAt!.toIso8601String() : null,
  };
}
