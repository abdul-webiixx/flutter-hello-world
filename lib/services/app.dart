import 'dart:convert';
import 'dart:io';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/constants/web_constants.dart';
import 'package:Zenith/model/all_instructor_model.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/auth_key.dart';
import 'package:http/http.dart' as http;
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/instructor_home.dart';
import 'package:Zenith/model/instructor_profile.dart';
import 'package:Zenith/model/notification.dart';
import 'package:Zenith/model/policy.dart';
import 'package:Zenith/model/review.dart';
import 'package:Zenith/model/search.dart';
import 'package:Zenith/model/state.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';

class AppService {
  late StateModel _stateModel;
  late ApiResponse _apiResponse;
  late HomeModel _homeModel;
  FirebaseService _firebaseService = new FirebaseService();
  late PrivacyPolicyModel _privacyPolicyModel;
  late ReviewModel _reviewModel;
  late NotificationModel _notificationModel;
  late SearchModel _searchModel;
  late AuthKeyModel _authKeyModel;
  late InstructorHomeModel _instructorHome;
  static late AllInstructorsModel __allinstructor;
  static late Instructor _instructor;
  late InstructorProfileModel _instructorProfileModel;
  // final MetricHttpClient metricHttpClient = MetricHttpClient(http.Client());

  Future<StateModel> fetchStateList() async {
    _stateModel = new StateModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetStateList);

    try {
      http.Response response = await http.get(url, headers: await authHeader());
      http.Request request = http.Request("fetchStateList", url);
      // metricHttpClient.send(request);
      _stateModel = new StateModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _stateModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _stateModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchStateList",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _stateModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchStateList",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchStateList",
        message: e.message,
        userId: "NA",
      );
      throw Failure(e.message);
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchStateList",
        message: e.message,
        userId: "NA",
      );
      throw Failure(e.message);
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchStateList",
        message: e.message,
        userId: "NA",
      );
      throw Failure(e.message);
    }
    return _stateModel;
  }

  Future<StateModel> fetchOfflineCenter() async {
    _stateModel = new StateModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetOfflineCenter);
    try {
      http.Response response = await http.get(url, headers: await authHeader());
      http.Request request = http.Request("fetchOfflineCenter", url);
      // metricHttpClient.send(request);
      _stateModel = new StateModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _stateModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _stateModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchOfflineCenter",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _stateModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchOfflineCenter",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchOfflineCenter",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchOfflineCenter",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchOfflineCenter",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _stateModel;
  }

  Future<PrivacyPolicyModel> fetchPrivacyPolicy(
      {required PolicyRequestFor requestFor}) async {
    _privacyPolicyModel = new PrivacyPolicyModel();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + _requestFor(requestFor));
    try {
      http.Response response =
          await http.post(url, headers: await authHeader());
      http.Request request = http.Request("fetchPrivacyPolicy", url);
      // metricHttpClient.send(request);
      _privacyPolicyModel =
          new PrivacyPolicyModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _privacyPolicyModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _privacyPolicyModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetch${_requestFor(requestFor)}",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _privacyPolicyModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetch${_requestFor(requestFor)}",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetch${_requestFor(requestFor)}",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetch${_requestFor(requestFor)}",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetch${_requestFor(requestFor)}",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _privacyPolicyModel;
  }

  Future<SearchModel> fetchSearch({required String keyword}) async {
    _searchModel = new SearchModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetSearch);
    try {
      Map<String, dynamic> paramBody = {
        'keyword': keyword,
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchSearch", url);
      // metricHttpClient.send(request);
      _searchModel = new SearchModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _searchModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _searchModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchSearch",
          message: response.body,
          userId: userId,
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500) {
        _searchModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchSearch",
          message: response.body,
          userId: userId,
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchSearch",
        message: e.message,
        userId: userId,
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchSearch",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchSearch",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Format Error");
    }
    return _searchModel;
  }

  Future<NotificationModel> fetchNotification({required int userId}) async {
    _notificationModel = new NotificationModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetNotification);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchNotification", url);
      // metricHttpClient.send(request);
      _notificationModel =
          new NotificationModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _notificationModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _notificationModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchNotification",
          message: response.body,
          userId: userId,
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500) {
        _notificationModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchNotification",
          message: response.body,
          userId: userId,
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchNotification",
        message: e.message,
        userId: userId,
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchNotification",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchNotification",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Format Error");
    }
    return _notificationModel;
  }

  Future<InstructorProfileModel> fetchInstructorProfile(
      {required int instructorId}) async {
    _instructorProfileModel = new InstructorProfileModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetInstructorProfile);
    try {
      Map<String, dynamic> paramBody = {
        'instructor_id': instructorId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchInstructorProfile", url);
      // metricHttpClient.send(request);
      _instructorProfileModel =
          new InstructorProfileModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _instructorProfileModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _instructorProfileModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchInstructorProfile",
          message: response.body,
          userId: userId,
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500) {
        _instructorProfileModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchInstructorProfile",
          message: response.body,
          userId: userId,
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchInstructorProfile",
        message: e.message,
        userId: userId,
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchInstructorProfile",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchInstructorProfile",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Format Error");
    }
    return _instructorProfileModel;
  }

  Future<ApiResponse> fetchAddInstructorReview(
      {required int userId,
      required double rating,
      required int instructorId,
      required review}) async {
    _apiResponse = new ApiResponse();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + GetAddInstructorReview);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'rating': rating.toString(),
        'review': review,
        'instructor_id': instructorId.toString()
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchAddInstructorReview", url);
      // metricHttpClient.send(request);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
            apiCall: "fetchAddInstructorReview",
            message: response.body,
            userId: userId,
            code: "401|404");
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
            apiCall: "fetchAddInstructorReview",
            message: response.body,
            userId: userId,
            code: "500|502|504");
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchAddInstructorReview",
        message: e.message,
        userId: userId,
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchAddInstructorReview",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchAddInstructorReview",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<ApiResponse> fetchNotificationStatus({required int userId}) async {
    _apiResponse = new ApiResponse();
    final Uri url =
        Uri.parse(GetBaseUrl + GetDomainUrl + GetNotificationStatus);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchNotificationStatus", url);
      // metricHttpClient.send(request);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
            apiCall: "fetchNotificationStatus",
            message: response.body,
            userId: userId,
            code: "401|404");
      } else if (response.statusCode == https_code_500) {
        _firebaseService.firebaseDioError(
            apiCall: "fetchNotificationStatus",
            message: response.body,
            userId: userId,
            code: "500|502|504");
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchNotificationStatus",
        message: e.message,
        userId: userId,
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchNotificationStatus",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchNotificationStatus",
        message: e.message,
        userId: userId,
      );
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<HomeModel> fetchHome({required int userId}) async {
    try {
      _homeModel = new HomeModel();
      final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetHome);
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchHome", url);
      // metricHttpClient.send(request);
      _homeModel = new HomeModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _homeModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _homeModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
            apiCall: "fetchHome",
            message: response.body,
            userId: userId,
            code: "401|404");
      } else if (response.statusCode == https_code_500) {
        _firebaseService.firebaseDioError(
            apiCall: "fetchHome",
            message: response.body,
            userId: userId,
            code: "500|502|504");
        _homeModel.requestStatus = RequestStatus.server;
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchHome",
        message: e.message,
        userId: userId,
      );
      throw Failure(e.message);
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchHome",
        message: e.message,
        userId: userId,
      );
      throw Failure(e.message);
    }
    return _homeModel;
  }

  Future<ReviewModel> fetchReviewList() async {
    _reviewModel = new ReviewModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetReview);
    try {
      http.Response response =
          await http.post(url, headers: await authHeader());
      http.Request request = http.Request("fetchReviewList", url);
      // metricHttpClient.send(request);
      _reviewModel = new ReviewModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _reviewModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _reviewModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchReviewList",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _reviewModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchReviewList",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchReviewList",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchReviewList",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchReviewList",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _reviewModel;
  }

  Future<ReviewModel> fetchSearchData() async {
    _reviewModel = new ReviewModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetReview);
    try {
      http.Response response =
          await http.post(url, headers: await authHeader());
      http.Request request = http.Request("fetchSearchData", url);
      // metricHttpClient.send(request);
      _reviewModel = new ReviewModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _reviewModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _reviewModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchReviewList",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _reviewModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchReviewList",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchReviewList",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchReviewList",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchReviewList",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _reviewModel;
  }

  String _requestFor(PolicyRequestFor requestFor) {
    String request = "";
    switch (requestFor) {
      case PolicyRequestFor.AboutUs:
        request = AboutUs;
        break;
      case PolicyRequestFor.PrivacyPolicy:
        request = PrivacyPolicy;
        break;
      case PolicyRequestFor.TermsAndUse:
        request = TermAndCondition;
        break;
    }
    return request;
  }

  Future<AuthKeyModel> fetchChatSupport({required int userId}) async {
    _authKeyModel = new AuthKeyModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetSupport);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchChatSupport", url);
      // metricHttpClient.send(request);
      _authKeyModel = new AuthKeyModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _authKeyModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _authKeyModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchChatSupport",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _authKeyModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchChatSupport",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchChatSupport",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchChatSupport",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchChatSupport",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _authKeyModel;
  }

  Future<AuthKeyModel> fetchRazorAuthKey({required int userId}) async {
    _authKeyModel = new AuthKeyModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetRazorKey);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
      };
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchRazorAuthKey", url);
      // metricHttpClient.send(request);
      _authKeyModel = new AuthKeyModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _authKeyModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _authKeyModel.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchRazorAuthKey",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _authKeyModel.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchRazorAuthKey",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchRazorAuthKey",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchRazorAuthKey",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchRazorAuthKey",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _authKeyModel;
  }

  Future<InstructorHomeModel> fetchInstructorHome({required int userId}) async {
    _instructorHome = new InstructorHomeModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetInstructorHome);
    Map<String, dynamic> paramBody = {
      'user_id': userId.toString(),
    };
    try {
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      http.Request request = http.Request("fetchInstructorHome", url);
      // metricHttpClient.send(request);
      _instructorHome =
          new InstructorHomeModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _instructorHome.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _instructorHome.requestStatus = RequestStatus.unauthorized;
        _firebaseService.firebaseDioError(
          apiCall: "fetchInstructorHome",
          message: response.body,
          userId: "NA",
          code: "401|404",
        );
      } else if (response.statusCode == https_code_500 ||
          response.statusCode == https_code_502 ||
          response.statusCode == https_code_504) {
        _instructorHome.requestStatus = RequestStatus.server;
        _firebaseService.firebaseDioError(
          apiCall: "fetchInstructorHome",
          message: response.body,
          userId: "NA",
          code: "500|502|504",
        );
      }
    } on SocketException catch (e) {
      _firebaseService.firebaseSocketException(
        apiCall: "fetchInstructorHome",
        message: e.message,
        userId: "NA",
      );
      throw Failure("No internet connection");
    } on HttpException catch (e) {
      _firebaseService.firebaseHttpException(
        apiCall: "fetchInstructorHome",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Request Error");
    } on FormatException catch (e) {
      _firebaseService.firebaseFormatException(
        apiCall: "fetchInstructorHome",
        message: e.message,
        userId: "NA",
      );
      throw Failure("Bad Format Error");
    }
    return _instructorHome;
  }

  static Future<AllInstructorsModel> getAllInstructor() async {
    __allinstructor = new AllInstructorsModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + getAllInstructors);
    try {
      http.Response response = await http.get(url);
      __allinstructor =
          new AllInstructorsModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
    return __allinstructor;
  }

  static Future<Instructor> getInstructorProfile({int? instructor_id}) async {
    _instructor = new Instructor();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + instructor);
    try {
      http.Response response = await http.post(url,
          body: {"instructor_id": "$instructor_id"},
          headers: await authHeader());
      var jsondata = jsonDecode(response.body);
      var encodedata = jsonEncode(jsondata["data"]);
      if (response.statusCode == 200) {
        _instructor = Instructor.fromJson(jsonDecode(encodedata));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return _instructor;
  }
}
