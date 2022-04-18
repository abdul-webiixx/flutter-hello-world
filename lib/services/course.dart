import 'dart:convert';
import 'dart:io';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/constants/web_constants.dart';
import 'package:Zenith/model/choreography.dart';
import 'package:Zenith/model/course_lesson.dart';
import 'package:Zenith/model/instructor_courses.dart';
import 'package:Zenith/model/instructor_lesson.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/comment.dart';
import 'package:Zenith/model/course.dart';
import 'package:Zenith/model/course_lesson_details.dart';
import 'package:Zenith/model/course_package.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';

class CourseService {
  late InstructorCoursesModel _instructorCoursesModel;
  late CourseModel _courseModel;
  late CoursePackageModel _coursePackageModel;
  late CourseLessonDetailsModel _courseLessonDetailsModel;
  late ApiResponse _apiResponse;
  late CommentModel _commentModel;
  late InstructorChoreographyModel _instructorChoreographyModel;
  late InstructorLessonModel _instructorLessonModel;
  late CourseLessonPackageModel _courseLessonPackageModel;





 Future<InstructorCoursesModel> fetchInstructorCourseData({required int userId})async{
    _instructorCoursesModel = new InstructorCoursesModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + InstructorCourses);
    try {
      Map<String, dynamic> paramBody = {
        "instructor_id": userId.toString()
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _instructorCoursesModel = new InstructorCoursesModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _courseModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _courseModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _courseModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {

      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _instructorCoursesModel;
  }











  Future<CourseModel> fetchCourseData({required int userId})async{
    _courseModel = new CourseModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCourses);
    try {
      Map<String, dynamic> paramBody = {
        "user_id": userId.toString()
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _courseModel = new CourseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _courseModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _courseModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _courseModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {

      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _courseModel;
  }

  Future<CoursePackageModel> fetchCoursePackageData({required int courseId})async{
    _coursePackageModel = new CoursePackageModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCoursePackage);
    try {
      Map<String, dynamic> paramBody = {
        "course_id": courseId.toString()
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _coursePackageModel = new CoursePackageModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _coursePackageModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _coursePackageModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _coursePackageModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _coursePackageModel;
  }

  Future<CourseModel> fetchCourseChoreography({required int courseId})async{
    _courseModel = new CourseModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetChoreographyData);
    try {
      Map<String, dynamic> paramBody = {
        "course_id": courseId.toString()
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _courseModel = new CourseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _courseModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _courseModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _courseModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _courseModel;
  }

  Future<CourseLessonPackageModel> fetchCourseLessonPackage({required int courseId,
    required int coursePackageId, required int userId, required int choreographyId})async{
    _courseLessonPackageModel = new CourseLessonPackageModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCoursePackageDetails);
    try {
      Map<String, dynamic> paramBody = {
        "course_id": courseId.toString(),
        "course_package_id": coursePackageId.toString(),
        "user_id": userId.toString(),
        "choreography_id": choreographyId.toString(),
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _courseLessonPackageModel = new CourseLessonPackageModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _courseLessonPackageModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _courseLessonPackageModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _courseLessonPackageModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _courseLessonPackageModel;
  }

  Future<CourseLessonDetailsModel> fetchCourseLessonPackageDetails({required int lessonId, required int courseId,
    required int packageId, required int userId, required int choreographyId })async{
    _courseLessonDetailsModel = new CourseLessonDetailsModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetCourseLessonDetails);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "course_id": courseId.toString(),
        "package_id": packageId.toString(),
        "user_id": userId.toString(),
        "choreography_id":choreographyId.toString()
      };

      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _courseLessonDetailsModel = new CourseLessonDetailsModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _courseLessonDetailsModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _courseLessonDetailsModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _courseLessonDetailsModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _courseLessonDetailsModel;
  }

  Future<ApiResponse> fetchAddComment({required int lessonId,
    required int packageId, required int userId, required String comments })async{
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetAddComment);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "package_id": packageId.toString(),
        "user_id": userId.toString(),
        "comment": comments,
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
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

  Future<ApiResponse> fetchAddLesson({required int lessonId,
    required int packageId, required int userId, required String comments })async{
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetAddComment);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "package_id": packageId.toString(),
        "user_id": userId.toString(),
        "comment": comments,
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
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


  Future<CommentModel> fetchGetComment({required int lessonId,
    required int packageId,})async{
    _commentModel = new CommentModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetComment);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "package_id": packageId.toString(),
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _commentModel = new CommentModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _commentModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _commentModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _commentModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _commentModel;
  }

  Future<ApiResponse> fetchAddLike({required int lessonId,
    required int packageId, required int userId})async{
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetAddLike);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "package_id": packageId.toString(),
        "user_id": userId.toString(),
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
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

  Future<ApiResponse> fetchRemoveLike({required int lessonId,
    required int packageId, required int userId})async{
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetRemoveLike);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "package_id": packageId.toString(),
        "user_id": userId.toString(),
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
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

  Future<InstructorChoreographyModel> fetchInstructorChoreography({required int instructorId,
    required int courseId,})async{
    _instructorChoreographyModel = new InstructorChoreographyModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetInstructorChoreography);
    try {
      Map<String, dynamic> paramBody = {
        "instructor_id": instructorId.toString(),
        "course_id": courseId.toString(),
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _instructorChoreographyModel = new InstructorChoreographyModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _instructorChoreographyModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _instructorChoreographyModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _instructorChoreographyModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _instructorChoreographyModel;
  }

  Future<InstructorLessonModel> fetchInstructorLesson({required int instructorId, required int choreographyId})async{
    _instructorLessonModel = new InstructorLessonModel();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetInstructorLesson);
    try {
      Map<String, dynamic> paramBody = {
        "instructor_id": instructorId.toString(),
          "choreography_id":choreographyId.toString()
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _instructorLessonModel = new InstructorLessonModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _instructorLessonModel.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
        _instructorLessonModel.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _instructorLessonModel.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _instructorLessonModel;
  }


  Future<ApiResponse> fetchInstructorLessonSequence({required int sequenceId, required int lessonId})async{
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetInstructorLessonSequence);
    try {
      Map<String, dynamic> paramBody = {
        "lesson_id": lessonId.toString(),
        "sequence_number":sequenceId.toString()
      };
      http.Response response =
      await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 || response.statusCode == https_code_401) {
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


  Future<ApiResponse> fetchInstructorAddLesson({required int instructorId,
    required int courseId, required int choreographyId, required title, required previewLesson,
    required status,  required String videoPath, required String videoName,
    required String description})async{
    _apiResponse = new ApiResponse();
      try {
        Dio dio = new Dio();
        String url = GetBaseUrl + GetDomainUrl + GetInstructorAddLesson;
        FormData params = FormData.fromMap({
          "instructor_id": instructorId,
          "description": description,
          "course_id":courseId,
          "choreography_id":choreographyId,
          "title":title,
          "preview_lesson":previewLesson,
          "status":status,
          "video": await MultipartFile.fromFile(videoPath, filename: videoName),
        });
        var response = await dio.post(url,
            options: new Options(headers: await authHeader()), data: params);
        _apiResponse = new ApiResponse.fromJson(response.data);
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
      return _apiResponse;
  }

  Future<ApiResponse> fetchInstructorUpdateLesson({required int lessonId,
    required title, required previewLesson,
    required status,  required String? videoPath, required String? videoName,
    required String description})async{
    _apiResponse = new ApiResponse();
    try {
      Dio dio = new Dio();
      String url = GetBaseUrl + GetDomainUrl + GetInstructorEditLesson;
      FormData params = FormData.fromMap({
        "lesson_id": lessonId,
        "description": description,
        "title":title,
        "preview_lesson":previewLesson,
        "status":status,
        "video": videoPath!=null && videoName!=null ?
        await MultipartFile.fromFile(videoPath, filename: videoName) : null,
      });
      var response = await dio.post(url,
          options: new Options(headers: await authHeader()), data: params);
      _apiResponse = new ApiResponse.fromJson(response.data);
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
    return _apiResponse;
  }

  Future<ApiResponse> fetchInstructorDeleteLesson({required int lessonId})async{
    _apiResponse = new ApiResponse();
    try {
      Dio dio = new Dio();
      String url = GetBaseUrl + GetDomainUrl + GetInstructorDeleteLesson;
      FormData params = FormData.fromMap({
        "lesson_id": lessonId,
      });
      var response = await dio.post(url,
          options: new Options(headers: await authHeader()), data: params);
      _apiResponse = new ApiResponse.fromJson(response.data);
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
    return _apiResponse;
  }

}