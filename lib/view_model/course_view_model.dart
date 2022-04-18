import 'package:Zenith/base/base_model.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/choreography.dart';
import 'package:Zenith/model/instructor_courses.dart';
import 'package:Zenith/model/instructor_lesson.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/comment.dart';
import 'package:Zenith/model/course.dart';
import 'package:Zenith/model/course_lesson.dart';
import 'package:Zenith/model/course_lesson_details.dart';
import 'package:Zenith/model/course_package.dart';
import 'package:Zenith/services/course.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CourseViewModel extends BaseModel {

  late CourseModel courseModel;
  late InstructorCoursesModel instructorCoursesModel;
  late CourseModel courseChoreographyModel;
  late InstructorLessonModel instructorLessonModel;


  late TextEditingController titleController;
  late TextEditingController lessonController;

  late int userId;
  late bool userAutoValidate;
  late String? autoValidationError;
  late CoursePackageModel _coursePackageModel;
  CoursePackageModel get coursePackageModel => _coursePackageModel;

  late CourseLessonPackageModel _courseLessonPackageModel;
  CourseLessonPackageModel get courseLessonPackageModel => _courseLessonPackageModel;

  late CourseLessonDetailsModel _courseLessonDetailsModel;
  CourseLessonDetailsModel get courseLessonDetailsModel => _courseLessonDetailsModel;

  late ApiResponse _apiResponse;
  ApiResponse get apiResponse => _apiResponse;

  late CommentModel _commentModel;
  CommentModel get commentModel => _commentModel;

  late InstructorChoreographyModel instructorChoreographyModel;

  late Failure _failure;
  Failure get failure => _failure;

  late CourseService _courseService;

  CourseViewModel.initializer() {
    courseModel = new CourseModel();
    instructorCoursesModel = new InstructorCoursesModel();
    _courseService = new CourseService();
    _coursePackageModel = new CoursePackageModel();
    _courseLessonDetailsModel = new CourseLessonDetailsModel();
    _apiResponse = new ApiResponse();
    _commentModel = new CommentModel();
    courseChoreographyModel = new CourseModel();
    titleController = new TextEditingController();
    lessonController = new TextEditingController();
    instructorChoreographyModel = new InstructorChoreographyModel();
    instructorLessonModel = new InstructorLessonModel();
    _courseLessonPackageModel = new CourseLessonPackageModel();
    userAutoValidate = false;
    autoValidationError = "";
    getUserId().then((value) {
     if(value!=null){
       userId = value;
       getCourseData(userId: value);
     }
    });
  }
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }
  set validationError(String msg) {
    autoValidationError = msg;
    notifyListeners();
  }
  void keyBoardDismiss(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

Future<void> getInstructorCourseData({required int userId}) async {
    instructorCoursesModel.requestStatus = RequestStatus.loading;
    try{
      instructorCoursesModel  = await _courseService.fetchInstructorCourseData(userId: userId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
  }

  Future<void> getCourseData({required int userId}) async {
    courseModel.requestStatus = RequestStatus.loading;
    try{
      courseModel  = await _courseService.fetchCourseData(userId: userId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
  }

  Future<void> getCoursePackageData({required int courseId}) async {
    _coursePackageModel.requestStatus = RequestStatus.loading;
    try{
      _coursePackageModel  = await _courseService.fetchCoursePackageData(courseId: courseId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
  }

  Future<void> getCourseChoreographyData({required int courseId}) async {
    courseChoreographyModel.requestStatus = RequestStatus.loading;
    try{
      courseChoreographyModel  = await _courseService.fetchCourseChoreography(courseId: courseId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
  }

  Future<CourseLessonPackageModel> getCourseLessonPackageData({required int courseId, required int coursePackageId,
    required int userId, required int choreographyId}) async {
    _courseLessonPackageModel.requestStatus = RequestStatus.loading;
    try{
      _courseLessonPackageModel  = await _courseService.fetchCourseLessonPackage(
          courseId: courseId, userId: userId, coursePackageId: coursePackageId, choreographyId: choreographyId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _courseLessonPackageModel;
  }

  Future<CourseLessonDetailsModel> getCourseLessonPackageDetails({required int lessonId, required int courseId,
    required int packageId, required int userId , required int choreographyId }) async {
    _courseLessonDetailsModel.requestStatus = RequestStatus.loading;
    try{
      _courseLessonDetailsModel  = await _courseService.fetchCourseLessonPackageDetails(
          lessonId: lessonId, courseId: courseId, packageId: packageId, userId: userId,
          choreographyId:choreographyId );
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _courseLessonDetailsModel;
  }

  Future<ApiResponse> getAddComment({required int lessonId, required int packageId,
    required int userId, required String comments }) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchAddComment(
          lessonId: lessonId, packageId: packageId, userId: userId,
          comments:comments );
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }

  Future<CommentModel> getComment({required int lessonId, required int packageId,}) async {
    _commentModel.requestStatus = RequestStatus.loading;
    try{
      _commentModel  = await _courseService.fetchGetComment(
          lessonId: lessonId, packageId: packageId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _commentModel;
  }

  Future<ApiResponse> getAddLike({required int lessonId, required int packageId, required int userId}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchAddLike(
          lessonId: lessonId, packageId: packageId, userId: userId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }

  Future<ApiResponse> getRemoveLike({required int lessonId, required int packageId, required int userId}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchRemoveLike(
          lessonId: lessonId, packageId: packageId, userId: userId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }

  Future<InstructorChoreographyModel> getInstructorChoreography({
    required int courseId}) async {
    instructorChoreographyModel.requestStatus = RequestStatus.loading;
    try{
      instructorChoreographyModel  = await _courseService.fetchInstructorChoreography(
          instructorId: userId, courseId: courseId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return instructorChoreographyModel;
  }

  Future<InstructorLessonModel> getInstructorLesson({required int choreographyId}) async {
    instructorLessonModel.requestStatus = RequestStatus.loading;
    try{
      instructorLessonModel  = await _courseService.fetchInstructorLesson(
          instructorId: userId,
          choreographyId: choreographyId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return instructorLessonModel;
  }


  Future<ApiResponse> getInstructorLessonSequence({required int lessonId, required int sequenceId}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchInstructorLessonSequence(
          lessonId: lessonId,
          sequenceId: sequenceId);
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }


  Future<ApiResponse> getInstructorAddLesson({
    required int courseId, required int choreographyId, required title, required previewLesson,
    required status,  required String videoPath, required String videoName,
    required String description}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchInstructorAddLesson(
        instructorId: userId,
        courseId: courseId,
        choreographyId: choreographyId,
        title: title,
        previewLesson: previewLesson,
        status: status,
        videoName: videoName,
        videoPath: videoPath,
        description: description
      );
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }

  Future<ApiResponse> getInstructorUpdateLesson({
    required int lessonId, required title, required previewLesson,
    required status,  required String? videoPath, required String? videoName,
    required String description}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchInstructorUpdateLesson(
          title: title,
          lessonId: lessonId,
          previewLesson: previewLesson,
          status: status,
          videoName: videoName,
          videoPath: videoPath,
          description: description
      );
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }

  Future<ApiResponse> getInstructorDeleteLesson({
    required int lessonId}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    try{
      _apiResponse  = await _courseService.fetchInstructorDeleteLesson(
          lessonId: lessonId,
      );
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
    return _apiResponse;
  }

  bool formValidator({ChoreographyData? choreographyData, XFile? file, required bool addNew
  }) {
    if (!isValidString(titleController.value.text.trim())) {
      userAutoValidate = false;
      validationError = enter_lesson_title;
    } else if (!isValidString(lessonController.value.text.trim())) {
      userAutoValidate = false;
      validationError = enter_lesson_name;
    } else if (addNew && choreographyData==null) {
      userAutoValidate = false;
      validationError = select_choreography;
    } else if(addNew && file==null){
      userAutoValidate = false;
      validationError = add_video;
    }else {
      userAutoValidate = true;
    }
    return userAutoValidate;
  }

}
