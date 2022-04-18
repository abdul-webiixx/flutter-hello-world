import 'package:Zenith/base/base_model.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/days.dart';
import 'package:Zenith/model/my_class.dart';
import 'package:Zenith/model/student.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/model/join_class.dart';
import 'package:Zenith/model/offline_class_package.dart';
import 'package:Zenith/model/service.dart';
import 'package:Zenith/model/service_package.dart';
import 'package:Zenith/model/service_type.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/services/class.dart';
import 'package:Zenith/utils/request_failure.dart';

class ClassViewModel extends BaseModel {

  late ClassModel _classModel;
  ClassModel get classModel => _classModel;
  late ClassService _classService;
  late int _classId;
  int get classId => _classId;
  late int _centerId;
  bool? _studentPresent;
  bool? get studentPresent=> _studentPresent;
  int get centerId => _centerId;
  ServiceModel get serviceModel => _serviceModel;
  late ServiceModel _serviceModel;
  late int _userId;
  int get userId=> _userId;
  ServiceTypeModel get serviceTypeModel => _serviceTypeModel;
  late ServiceTypeModel _serviceTypeModel;

  MyClassModel get myClassModel => _myClassModel;
  late MyClassModel _myClassModel;

  ApiResponse get apiResponse => _apiResponse;
  late ApiResponse _apiResponse;

  StudentModel get studentModel => _studentModel;
  late StudentModel _studentModel;

  ServicePackage get servicePackage => _servicePackage;
  late ServicePackage _servicePackage;

  DaysModel get daysModel => _daysModel;
  late DaysModel _daysModel;

  UpcomingLiveClassesModel get upcomingLiveClassesModel => _upcomingLiveClassesModel;
  late UpcomingLiveClassesModel _upcomingLiveClassesModel;

  JoinClassModel get joinClassModel => _joinClassModel;
  late JoinClassModel _joinClassModel;

  OfflineClassPackageModel get offlineClassPackageModel => _offlineClassPackageModel;
  late OfflineClassPackageModel _offlineClassPackageModel;

  late Failure _failure;
  Failure get failure => _failure;

  ClassViewModel.initializer() {
    _userId = 0;
    _classModel = new ClassModel();
    _serviceModel = new ServiceModel();
    _servicePackage = new ServicePackage();
    _serviceTypeModel = new ServiceTypeModel();
    _joinClassModel = new JoinClassModel();
    _upcomingLiveClassesModel = new UpcomingLiveClassesModel();
    _classService =new ClassService();
    _offlineClassPackageModel= new OfflineClassPackageModel();
    _myClassModel = new MyClassModel();
    _studentModel = new StudentModel();
    _apiResponse = new ApiResponse();
    _daysModel = new DaysModel();
    getClassData();
    getServiceData();

    getUserId().then((value) {
      if(value!=null){
        _userId = value;
       getMyClass(userId: value);
      }
    });
  }
  void setClassId({required int classId}){
    _classId = classId;
  }

  void setCenterId({required int centerId}){
    _centerId = centerId;
  }

  void resetBuilder(){
    _studentModel = new StudentModel();
    notifyListeners();
  }
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  Future<void> getClassData() async {
    _classModel.requestStatus = RequestStatus.loading;
    try{
      _classModel  = await _classService.fetchClassData();
      notifyListeners();
    } on Failure catch (f){
      _setFailure(f);
    }
  }

  Future<void> getServiceData() async {
    _serviceModel.requestStatus = RequestStatus.loading;
    _serviceModel  = await _classService.fetchServiceData();
    notifyListeners();
  }
  Future<void> getServiceTypeData({required int serviceId}) async {
    _serviceTypeModel.requestStatus = RequestStatus.loading;
    _serviceTypeModel  = await _classService.fetchServiceTypeData(serviceId: serviceId);
    notifyListeners();
  }
  Future<ServicePackage> getServicePackage({required int serviceId, required int serviceTypeId, required int classId}) async {
    _servicePackage.requestStatus = RequestStatus.loading;
    try{
      _servicePackage  = await _classService.fetchServicePackage(
          serviceId: serviceId,
          classId: classId,
          serviceTypeId: serviceTypeId);
      notifyListeners();
    } on Failure catch (f){
      _servicePackage.requestStatus = RequestStatus.failure;
      _setFailure(f);
    }
    return _servicePackage;
  }

  Future<UpcomingLiveClassesModel> getUpcomingLiveClasses({required int userId}) async {
    _upcomingLiveClassesModel.requestStatus = RequestStatus.loading;
    _upcomingLiveClassesModel  = await _classService.fetchUpcomingLiveClasses(
        userId: userId);
    notifyListeners();
    return _upcomingLiveClassesModel;
  }

  Future<UpcomingLiveClassesModel> getUpcomingDemoClasses({required int userId}) async {
    _upcomingLiveClassesModel.requestStatus = RequestStatus.loading;
    _upcomingLiveClassesModel  = await _classService.fetchUpcomingDemoClasses(
        userId: userId);
    notifyListeners();
    return _upcomingLiveClassesModel;
  }

  Future<JoinClassModel> getJoinClass({required int userId, required int packageId}) async {
    _joinClassModel.requestStatus = RequestStatus.loading;
    _joinClassModel  = await _classService.fetchJoinClasses(
        userId: userId,
        packageId: packageId);
    notifyListeners();
    return _joinClassModel;
  }

  Future<void> getOfflineServiceData() async {
    _serviceModel.requestStatus = RequestStatus.loading;
    _serviceModel  = await _classService.fetchOfflineServiceData();
    notifyListeners();
  }

  Future<void> getOfflineServiceTypeData({required int serviceId,
    required String type, required int classId}) async {
    _offlineClassPackageModel  = await _classService.fetchOfflineServiceTypeData(
        serviceId: serviceId, classId: classId, type: type
    );
    notifyListeners();
  }

  Future<void> getMyClass({required int userId}) async {
    _myClassModel.requestStatus = RequestStatus.loading;
    _myClassModel  = await _classService.fetchMyClass(
        userId: userId);
    notifyListeners();
  }

  Future<void> getStudent({required int instructorId,required int classId,
    required String date,}) async {
    _studentModel.requestStatus = RequestStatus.loading;
    _studentModel  = await _classService.fetchStudent(
        date: date, classId: classId, instructorId: instructorId
    );
    notifyListeners();
  }

  Future<void> getUpdateAttendance({required int userId, required int classId,
    required String date,required packageId, required String status}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    _apiResponse  = await _classService.fetchUpdateUserAttendance(
        date: date, classId: classId, userId: userId, status: status, packageId:packageId
    );
    notifyListeners();
  }

  Future<DaysModel> getDays({required int classId}) async {
    _daysModel.requestStatus = RequestStatus.loading;
    _daysModel  = await _classService.fetchDays(
      classId: classId,
    );
    notifyListeners();
    return _daysModel;
  }

  Future<ApiResponse> getManualAttendance({required int userId, required int classId,
    required String date, required String status}) async {
    _apiResponse.requestStatus = RequestStatus.loading;
    _apiResponse  = await _classService.fetchManualAttendance(
        date: date,
        classId: classId,
        userId: userId,
        status: status
    );
    notifyListeners();
    return _apiResponse;
  }

  void setStudentPresent(bool status){
    _studentPresent = status;
    notifyListeners();
  }
}
