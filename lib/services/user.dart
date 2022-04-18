import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/constants/web_constants.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/profile.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';
import 'firebase.dart';

class UserService{
  late ProfileModel _profileModel;
  late ApiResponse _apiResponse;
  late SignUpModel _signUpModel;
  FirebaseService _firebaseService =  new FirebaseService();

  Future<ProfileModel> fetchProfileModel(
      {required int userId}) async {
    _profileModel = ProfileModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetUserProfile);
    Map<String, dynamic> paramBody = {'user_id': userId.toString(),};
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _profileModel = new ProfileModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _profileModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {

        _profileModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _profileModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _profileModel;
  }

  Future<bool> fetchProfilePicUpdate(
      {required int userId, required String imagePath, required String imageName}) async {
    bool status = false;
    try {
      Dio dio = new Dio();
      String url = GetBaseUrl + GetDomainUrl + GetProfilePicUpdate;
      FormData params = FormData.fromMap({
        "user_id": userId,
        "image": await MultipartFile.fromFile(imagePath, filename: imageName),
      });
      var response = await dio.post(url,
          options: new Options(headers: await authHeader()), data: params);
        if(response.data["status"]!=null && response.data["status"]){
          status = true;
        }
    } on DioError catch (e) {
      if(e.response!=null){
        if(e.response!.statusCode==401 || e.response!.statusCode==404){
          _apiResponse.requestStatus = RequestStatus.unauthorized;
        }else if(e.response!.statusCode==500 || e.response!.statusCode==502 || e.response!.statusCode==504){
         _apiResponse.requestStatus = RequestStatus.server;
        }
      }}on SocketException catch(e){
      throw Failure(e.message);
    } on FormatException catch(e){
      throw Failure(e.message);
    } on HttpException catch(e){
      throw Failure(e.message);
    }
    return status;
  }

  Future<ProfileModel> fetchProfileDataUpdate(
      {required int userId, required String name,
        required String email, required String dob,
        required address, required String gender}) async {
    _profileModel = new ProfileModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetEditProfile);
    Map<String, dynamic> paramBody = {
      "user_id": userId.toString(),
      'name': name,
      'email': email,
      'gender': gender,
      'dob': dob,
      'address':address
       };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _profileModel = new ProfileModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _profileModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _profileModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _profileModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _profileModel;
  }

  Future<SignUpModel> fetchUserSignUp(
      {required String name,
        required String email,
        required String password,
        required String? deviceToken,
        required String? version,
        required String? model,
        required String mobile}) async {
    _signUpModel = new SignUpModel();
    _signUpModel.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + Register);
    Map<String, dynamic> paramBody = {
      'name': name,
      'email': email,
      'password': password,
      'mobile_number': "91$mobile",
      'device_token': deviceToken, 'version':version, 'model':model};
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _signUpModel = new SignUpModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _signUpModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _signUpModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _signUpModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _signUpModel;
  }

  Future<SignUpModel> fetchTrainerSignUp(
      {required String name,
        required String email,
        required String password,
        required String? deviceToken,
        required String? version,
        required String? model,
        required String mobile}) async {
    _signUpModel = new SignUpModel();
    _signUpModel.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + InstructorRegister);
    Map<String, dynamic> paramBody = {
      'name': name,
      'email': email,
      'password': password,
      'mobile_number': "91$mobile",
      'device_token': deviceToken, 'version':version, 'model':model};
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _signUpModel = new SignUpModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _signUpModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _signUpModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _signUpModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _signUpModel;
  }

  Future<SignUpModel> fetchUserLogin(
      {required String email,
        required String password,
        required String? deviceToken,
        required String? version,
        required String? model}) async {
    _signUpModel = new SignUpModel();
    _signUpModel.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + Login);
    Map<String, dynamic> paramBody = {'email': email, 'password': password,
      'device_token': deviceToken, 'version':version, 'model':model};
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _signUpModel = new SignUpModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _signUpModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _signUpModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(code: "401|404", apiCall: "getUserLogin",email: email, message: response.body, );
      } else if (response.statusCode == https_code_500) {
        _signUpModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _signUpModel;
  }

  Future<SignUpModel> fetchVerifyLoginWithOtp({required String mobile, required String otp}) async {
    _signUpModel = new SignUpModel();
    _signUpModel.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(
        GetBaseUrl + GetDomainUrl + GetVerifyLoginWithOtp);
    Map<String, dynamic> paramBody = {
      "mobile_number": "91$mobile",
      "otp": otp,
      "device_token": await getDeviceToken(),
      'version':await getDeviceVersion(), 'model':await getDeviceModel()
      };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _signUpModel = new SignUpModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _signUpModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _signUpModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _signUpModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _signUpModel;
  }

  Future<SignUpModel> fetchLoginWithOtp({required String mobile}) async {
    _signUpModel = new SignUpModel();
    _signUpModel.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetLoginWithOtp);
    Map<String, dynamic> paramBody = {
      "mobile_number": "91$mobile"
    };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _signUpModel = new SignUpModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _signUpModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _signUpModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _signUpModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _signUpModel;
  }

  Future<ApiResponse> fetchResendOtp({required String mobile}) async {
    _apiResponse = new ApiResponse();
    _apiResponse.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetResendOtp);
    Map<String, dynamic> paramBody = {
      "mobile_number":  "91$mobile"
    };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<ApiResponse> fetchSendOtp({required String mobile}) async {
    _apiResponse = new ApiResponse();
    _apiResponse.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetSendOtp);
    Map<String, dynamic> paramBody = {
      "mobile_number": "91$mobile"
    };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<SignUpModel> fetchVerifyOtp({required String mobile, required String otp}) async {
    _signUpModel = new SignUpModel();
    _signUpModel.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(
        GetBaseUrl + GetDomainUrl + GetVerifyOtp);
    Map<String, dynamic> paramBody = {
      "mobile_number":  "91$mobile",
      "otp": otp,
      "device_token": await getDeviceToken(),
      'version':await getDeviceVersion(), 'model':await getDeviceModel()
    };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _signUpModel = new SignUpModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _signUpModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _signUpModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _signUpModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _signUpModel;
  }

  Future<ApiResponse> fetchResendEmailOtp({required String email}) async {
    _apiResponse = new ApiResponse();
    _apiResponse.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetResendEmailOtp);
    Map<String, dynamic> paramBody = {
      "email_address": email
    };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<ApiResponse> fetchVerifyEmail({required String otp, required String emailId}) async {
    _apiResponse = new ApiResponse();
    _apiResponse.requestStatus = RequestStatus.loading;
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetAddEmail);
    Map<String, dynamic> paramBody = {
      "email_address": emailId,
      "otp": otp,
    };
    try {
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }
}