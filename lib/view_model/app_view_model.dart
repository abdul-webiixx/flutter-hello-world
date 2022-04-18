import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/provider/cartIcon.dart';
import 'package:Zenith/services/cart.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:Zenith/base/base_model.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/auth_key.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/instructor_home.dart';
import 'package:Zenith/model/instructor_profile.dart';
import 'package:Zenith/model/notification.dart';
import 'package:Zenith/model/policy.dart';
import 'package:Zenith/model/review.dart';
import 'package:Zenith/model/search.dart';
import 'package:Zenith/model/state.dart';
import 'package:Zenith/services/app.dart';
import 'package:Zenith/services/failure.dart';
import 'package:Zenith/utils/data_provider.dart';

class AppViewModel extends BaseModel {
  late ApiResponse _apiResponse;
  ApiResponse get apiResponse => _apiResponse;

  late bool userAutoValidate;
  late String? autoValidationError;

  late StateModel _stateModel;
  StateModel get stateModel => _stateModel;

  late int? _userId;
  int? get userId => _userId;

  late int? _cartItemCount = 0;
  int? get cartItemCount => _cartItemCount;

  late AuthKeyModel _authKeyModel;
  AuthKeyModel get authKeyModel => _authKeyModel;

  late SearchModel _searchModel;
  SearchModel get searchModel => _searchModel;

  late HomeModel _homeModel;
  HomeModel get homeModel => _homeModel;

  late Failure _failure;
  Failure get failure => _failure;

  late StateListItem _stateListItem;
  StateListItem get stateListItem => _stateListItem;

  late PrivacyPolicyModel _privacyPolicyModel;
  PrivacyPolicyModel get privacyPolicyModel => _privacyPolicyModel;

  late ReviewModel _reviewModel;
  ReviewModel get reviewModel => _reviewModel;

  late InstructorHomeModel _instructorHomeModel;
  InstructorHomeModel get instructorHomeModel => _instructorHomeModel;

  late InstructorProfileModel _instructorProfileModel;
  InstructorProfileModel get instructorProfileModel => _instructorProfileModel;

  late NotificationModel _notificationModel;
  NotificationModel get notificationModel => _notificationModel;

  late TextEditingController keywordController;

  late AppService _appService;

  late CartService _cartService;

  late CartModel _CartModel;

  late TextEditingController reviewController;
  AppViewModel.initializer() {
    _userId = null;
    _CartModel = new CartModel();
    _cartService = new CartService();
    keywordController = new TextEditingController();
    _apiResponse = new ApiResponse();
    _stateModel = new StateModel();
    _homeModel = new HomeModel();
    _appService = new AppService();
    _stateListItem = new StateListItem();
    _privacyPolicyModel = new PrivacyPolicyModel();
    _reviewModel = new ReviewModel();
    _notificationModel = new NotificationModel();
    _searchModel = new SearchModel();
    _authKeyModel = new AuthKeyModel();
    _instructorHomeModel = new InstructorHomeModel();
    reviewController = new TextEditingController();
    _instructorProfileModel = new InstructorProfileModel();
    userAutoValidate = false;
    autoValidationError = "";
    getUserId().then((value) {
      if (value != null) {
        _userId = value;
        getHome(userId: value);
        getStateList();
        getNotification(userId: value);
        getReviewList();
        getInstructorHome(userId: value);
      }
    });
  }

  Future<void> setUserId(int? userId) async {
    _userId = userId;
    notifyListeners();
  }

  getCartItemsCouunt() async {
    getUserId().then((muserId) async {
      _cartService.fetchCartData(userId: muserId!).then((value) {
        _cartItemCount = value.cartData!.cartItems!.length;
      });
    });
    // ItemCount.seticondata(_cartItemCount);
    notifyListeners();
  }

  Future<void> getStateList() async {
    try {
      _stateModel = await _appService.fetchStateList();
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _stateModel.requestStatus = RequestStatus.failure;
      notifyListeners();
    }
  }

  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  Future<void> getReviewList() async {
    try {
      _reviewModel = await _appService.fetchReviewList();
      notifyListeners();
    } on Failure catch (e) {
      _reviewModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
      notifyListeners();
    }
  }

  Future<void> getPrivacyPolicy({required PolicyRequestFor requestFor}) async {
    try {
      _privacyPolicyModel =
          await _appService.fetchPrivacyPolicy(requestFor: requestFor);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      notifyListeners();
    }
  }

  Future<void> getHome({
    required int userId,
  }) async {
    try {
      _homeModel.requestStatus = RequestStatus.loading;
      _homeModel = await _appService.fetchHome(
        userId: userId,
      );
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _homeModel.requestStatus = RequestStatus.failure;
      notifyListeners();
    }
  }

  Future<void> getOfflineCenter() async {
    try {
      _stateModel.requestStatus = RequestStatus.loading;
      _stateModel = await _appService.fetchOfflineCenter();
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _stateModel.requestStatus = RequestStatus.failure;
      notifyListeners();
    }
  }

  Future<void> getNotification({required int? userId}) async {
    try {
      _notificationModel.requestStatus = RequestStatus.loading;
      _notificationModel = await _appService.fetchNotification(userId: userId!);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _notificationModel.requestStatus = RequestStatus.failure;
    }
  }

  Future<void> getInstructorProfile({required int instructorId}) async {
    try {
      _instructorProfileModel.requestStatus = RequestStatus.loading;
      _instructorProfileModel =
          await _appService.fetchInstructorProfile(instructorId: instructorId);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _instructorProfileModel.requestStatus = RequestStatus.failure;
    }
  }

  Future<ApiResponse> getAddInstructorReview(
      {required int userId,
      required double rating,
      required int instructorId,
      required review}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      _apiResponse = await _appService.fetchAddInstructorReview(
          userId: userId,
          rating: rating,
          review: review,
          instructorId: instructorId);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _apiResponse.requestStatus = RequestStatus.failure;
    }
    return _apiResponse;
  }

  Future<ApiResponse> getNotificationStatus({required int userId}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      _apiResponse = await _appService.fetchNotificationStatus(
        userId: userId,
      );
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _apiResponse.requestStatus = RequestStatus.failure;
    }
    return _apiResponse;
  }

  Future<SearchModel> getSearch({required String keyword}) async {
    try {
      _searchModel.requestStatus = RequestStatus.loading;
      _searchModel = await _appService.fetchSearch(keyword: keyword);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
      _searchModel.requestStatus = RequestStatus.failure;
      notifyListeners();
    }
    return _searchModel;
  }

  Future<AuthKeyModel> getChatSupport(int userId) async {
    try {
      _authKeyModel.requestStatus = RequestStatus.loading;
      _authKeyModel = await _appService.fetchChatSupport(userId: userId);
      notifyListeners();
    } on Failure catch (e) {
      _authKeyModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _authKeyModel;
  }

  Future<AuthKeyModel> getRazorAuthKey({required int userId}) async {
    try {
      _authKeyModel.requestStatus = RequestStatus.loading;
      _authKeyModel = await _appService.fetchRazorAuthKey(userId: userId);
      notifyListeners();
    } on Failure catch (e) {
      _authKeyModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _authKeyModel;
  }

  Future<InstructorHomeModel> getInstructorHome({required int userId}) async {
    try {
      _instructorHomeModel.requestStatus = RequestStatus.loading;
      _instructorHomeModel =
          await _appService.fetchInstructorHome(userId: userId);
      notifyListeners();
    } on Failure catch (e) {
      _instructorHomeModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _instructorHomeModel;
  }

  bool formValidator(double rating) {
    if (!isValidString(reviewController.value.text.trim())) {
      autoValidationError = in_complete_review;
      userAutoValidate = false;
    } else if (rating == 0.0) {
      autoValidationError = in_complete_rating;
      userAutoValidate = false;
    } else {
      userAutoValidate = true;
    }
    notifyListeners();
    return userAutoValidate;
  }

  set validationError(String msg) {
    autoValidationError = msg;
    notifyListeners();
  }
}
