// To parse this JSON data, do
//
//     final apiResponse = apiResponseFromJson(jsonString);

import 'dart:convert';
import 'package:Zenith/utils/enum.dart';

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  ApiResponse({
    this.status,
    this.success = false,
    this.message,
    this.requestStatus = RequestStatus.initial

  });

  final int? status;
  final dynamic success;
  final String? message;
  RequestStatus requestStatus;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
  };
}
