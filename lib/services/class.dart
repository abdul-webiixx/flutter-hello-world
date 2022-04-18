import 'dart:convert';
import 'dart:io';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/constants/web_constants.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/days.dart';
import 'package:Zenith/model/my_class.dart';
import 'package:Zenith/model/student.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:http/http.dart' as http;
import 'package:Zenith/model/class.dart';
import 'package:Zenith/model/join_class.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/offline_class_package.dart';
import 'package:Zenith/model/service.dart';
import 'package:Zenith/model/service_package.dart';
import 'package:Zenith/model/service_type.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';

class ClassService {
  late ClassModel _classModel;
  late ServiceModel _serviceModel;
  late ServiceTypeModel _serviceTypeModel;
  late ServicePackage _servicePackage;
  late UpcomingLiveClassesModel _upcomingLiveClassesModel;
  late JoinClassModel _joinClassModel;
  late OfflineClassPackageModel _offlineClassPackageModel;
  late MyClassModel _myClassModel;
  late StudentModel _studentModel;
  late ApiResponse _apiResponse;
  late DaysModel _daysModel;

  Future<ClassModel> fetchClassData() async {
    _classModel = new ClassModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetClasses);
    try {
      http.Response response = await http.get(url, headers: await authHeader());
      _classModel = new ClassModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _classModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _classModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _classModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _classModel;
  }

  Future<ServiceModel> fetchServiceData() async {
    _serviceModel = new ServiceModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetService);
    try {
      http.Response response = await http.get(url, headers: await authHeader());
      _serviceModel = new ServiceModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _serviceModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _serviceModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _serviceModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _serviceModel;
  }

  Future<ServiceTypeModel> fetchServiceTypeData(
      {required int serviceId}) async {
    _serviceTypeModel = new ServiceTypeModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetServiceType);
    try {
      Map<String, dynamic> paramBody = {'service_id': serviceId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _serviceTypeModel =
          new ServiceTypeModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _serviceTypeModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _serviceTypeModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _serviceTypeModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _serviceTypeModel;
  }

  Future<ServicePackage> fetchServicePackage(
      {required int serviceId,
      required int serviceTypeId,
      required int classId}) async {
    _servicePackage = new ServicePackage();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetServicePackage);
    try {
      Map<String, dynamic> paramBody = {
        'service_id': serviceId.toString(),
        'service_type_id': serviceTypeId.toString(),
        'class_id': classId.toString()
      };
      printLog("fetchServicePackage-P", paramBody);
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      printLog("fetchServicePackage-R", response.body);
      _servicePackage = new ServicePackage.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _servicePackage.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _servicePackage.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _servicePackage.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _servicePackage;
  }

  Future<UpcomingLiveClassesModel> fetchUpcomingLiveClasses(
      {required int userId}) async {
    _upcomingLiveClassesModel = new UpcomingLiveClassesModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetUpcomingLiveClass);
    try {
      Map<String, dynamic> paramBody = {"user_id": userId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _upcomingLiveClassesModel =
          new UpcomingLiveClassesModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _upcomingLiveClassesModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _upcomingLiveClassesModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _upcomingLiveClassesModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _upcomingLiveClassesModel;
  }

  Future<UpcomingLiveClassesModel> fetchUpcomingDemoClasses(
      {required int userId}) async {
    _upcomingLiveClassesModel = new UpcomingLiveClassesModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetUpcomingDemoClass);
    try {
      Map<String, dynamic> paramBody = {"user_id": userId.toString()};
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _upcomingLiveClassesModel =
          new UpcomingLiveClassesModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _upcomingLiveClassesModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _upcomingLiveClassesModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _upcomingLiveClassesModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _upcomingLiveClassesModel;
  }

  Future<JoinClassModel> fetchJoinClasses(
      {required int userId, required int packageId}) async {
    _joinClassModel = new JoinClassModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetJoinClass);
    try {
      Map<String, dynamic> paramBody = {
        "user_id": userId.toString(),
        "package_id": packageId.toString()
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      printLog("nkjnjnk", response.body);
      printLog("nkjnjnk", paramBody);
      _joinClassModel = new JoinClassModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _joinClassModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _joinClassModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _joinClassModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _joinClassModel;
  }

  Future<ServiceModel> fetchOfflineServiceData() async {
    _serviceModel = new ServiceModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetOfflineService);
    try {
      http.Response response = await http.get(url, headers: await authHeader());
      _serviceModel = new ServiceModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _serviceModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _serviceModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _serviceModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _serviceModel;
  }

  Future<OfflineClassPackageModel> fetchOfflineServiceTypeData(
      {required int serviceId,
      required int classId,
      required String type}) async {
    _offlineClassPackageModel = new OfflineClassPackageModel();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + GetOfflineServiceType);
    try {
      Map<String, dynamic> paramBody = {
        'service_id': serviceId.toString(),
        'type': type,
        'class_id': classId.toString()
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _offlineClassPackageModel =
          new OfflineClassPackageModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _offlineClassPackageModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _offlineClassPackageModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _offlineClassPackageModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _offlineClassPackageModel;
  }

  Future<MyClassModel> fetchMyClass({required int userId}) async {
    _myClassModel = new MyClassModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetMyClass);
    try {
      Map<String, dynamic> paramBody = {
        'instructor_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _myClassModel = new MyClassModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _myClassModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _myClassModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _myClassModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _myClassModel;
  }

  Future<StudentModel> fetchStudent(
      {required int instructorId,
      required int classId,
      required String date}) async {
    _studentModel = new StudentModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetStudents);
    try {
      Map<String, dynamic> paramBody = {
        'instructor_id': instructorId.toString(),
        'date': date,
        'class_id': classId.toString()
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _studentModel = new StudentModel.fromJson(jsonDecode(response.body));
      printLog("nkjnjknj", _studentModel.toJson());
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _studentModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _studentModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _studentModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _studentModel;
  }

  Future<ApiResponse> fetchUpdateUserAttendance(
      {required int userId,
      required int classId,
      required String date,
        required int packageId,
      required String status}) async {
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetUpdateAttendance);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'class_id': classId.toString(),
        'date': date,
        'package_id':packageId.toString(),
        'status': status
      };
      printLog("P-fetchUpdateUserAttendance", paramBody.toString());
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      printLog("R-fetchUpdateUserAttendance",response.body);
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

  Future<DaysModel> fetchDays({required int classId}) async {
    _daysModel = new DaysModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetDays);
    try {
      Map<String, dynamic> paramBody = {
        'class_id': classId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      printLog("kjnnjnkjnj", response.body);
      _daysModel = new DaysModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _daysModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _daysModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _daysModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _daysModel;
  }

  Future<ApiResponse> fetchManualAttendance(
      {required int userId,
      required int classId,
      required String date,
      required String status}) async {
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetManualAttendance);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'class_id': classId.toString(),
        'date': date,
        'status': status
      };
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
