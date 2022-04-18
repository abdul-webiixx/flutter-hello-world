// To parse this JSON data, do
//
//     final signUp = signUpFromJson(jsonString);
import 'package:Zenith/utils/enum.dart';
import 'sign_up.dart';


class ProfileModel {
  ProfileModel({
    this.status,
    this.success = false,
    this.message,
    this.userInformation,
    this.requestStatus = RequestStatus.loading
  });

  final int? status;
  final String? message;
  final dynamic success;
  final UserInformation? userInformation;
  late RequestStatus requestStatus;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    success: json["success"],
    userInformation:json["data"]!=null ? UserInformation.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": userInformation!=null ? userInformation!.toJson() : null,
  };
}

