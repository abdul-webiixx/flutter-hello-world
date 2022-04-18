import 'dart:io';

class UserProfileModel {
  int? userId;
  String? name;
  String? email;
  String? avatar;
  String? password;
  String? gender;
  String? dob;
  String? imagePath;
  String? address;
  String? referCode;
  int? stateCode;
  String? mobile;
  bool? loginWithOtp;
  File? image;
  String? imageName;
  String? city;
  String? deviceToken;
  int? isEmailVerified;


  UserProfileModel(
      {this.userId,
        this.name,
        this.email,
        this.password,
        this.referCode,
        this.stateCode,
        this.mobile,
        this.loginWithOtp,
        this.deviceToken,
        this.address,
        this.imagePath,
        this.dob,
        this.imageName,
        this.gender,
        this.avatar,
        this.city,
        this.image});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    referCode = json['referCode'];
    stateCode = json['stateCode'];
    mobile = json['mobile'];
    loginWithOtp = json["loginWithOtp"];
    deviceToken = json["deviceToken"];
    gender = json["gender"];
    address = json["address"];
    dob = json["dob"];
    avatar = json["avatar"];
    image = json["image"];
    imagePath = json["image_path"];
    imageName = json["image_name"];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['referral_code'] = this.referCode;
    data['state_id'] = this.stateCode;
    data['mobile_number'] = this.mobile;
    data['loginWithOtp'] = this.loginWithOtp;
    data['deviceToken'] = this.deviceToken;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['image'] = this.image;
    data['image_path']= this.imagePath;
    data['image_name']= this.imageName;
    data['city']= this.city;
    data["avatar"]= this.avatar;
    return data;
  }
}
