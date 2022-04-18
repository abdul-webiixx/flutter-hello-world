// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/class.dart';

ServiceModel serviceModel(String str) => ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ClassModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    this.status,
    this.success = false,
    this.message,
    this.classPage,
    this.storagePath,
    this.requestStatus = RequestStatus.initial,
  });

  final int? status;
  final dynamic success;
  final String? message;
  final Class? classPage;
  final String? storagePath;
  late RequestStatus requestStatus;


  factory ServiceModel.fromJson(Map<String, dynamic> json){
    if(json["storage_path"]!=null){
      homeStoragePath = json["storage_path"];
    }
    return  ServiceModel(
      status: json["status"],
      success: json["success"],
      message: json["message"],
      storagePath: json["storage_path"],
      classPage:json["data"]!=null ?  Class.fromJson(json["data"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": classPage!=null ?  classPage!.toJson() : null,
  };
}
