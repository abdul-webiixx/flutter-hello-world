import 'package:Zenith/base/base_model.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/model/profile.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/services/user.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';
import 'package:Zenith/validator/validate.dart';

class UserViewModel extends BaseModel {
  late bool isHide;
  late bool cbRememberMe;
  late bool userAutoValidate;
  late String? autoValidationError;
  late String? deviceToken;
  late String? deviceModel;
  late UserType _userType;
  UserType get userType => _userType;
  late String? deviceVersion;
  late int? _userId;
  int? get userId => _userId;
  late TextEditingController referController;
  late TextEditingController genderController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController dobController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController address1Controller;
  late TextEditingController address2Controller;
  late TextEditingController cityController;
  late TextEditingController gstController;
  late TextEditingController zipCodeController;
  late TextEditingController stateController;
  late TextEditingController otpController;
  late TextEditingController studentIdController;
  late UserService _userService;

  OtpFor _otpFor = OtpFor.Login;
  OtpFor get otpFor => _otpFor;

  late SignUpModel _signUpModel;
  SignUpModel get signUpModel => _signUpModel;

  late ProfileModel _profileModel;
  ProfileModel get profileModel => _profileModel;

  late ApiResponse _apiResponse;
  ApiResponse get apiResponse => _apiResponse;

  late Failure _failure;
  Failure get failure => _failure;

  UserViewModel.initializer() {
    _signUpModel = new SignUpModel();
    _profileModel = new ProfileModel();
    _userService = new UserService();
    referController = new TextEditingController();
    emailController = new TextEditingController();
    nameController = new TextEditingController();
    passwordController = new TextEditingController();
    address1Controller = new TextEditingController();
    address2Controller = new TextEditingController();
    cityController = new TextEditingController();
    zipCodeController = new TextEditingController();
    stateController = new TextEditingController();
    mobileController = new TextEditingController();
    otpController = new TextEditingController();
    genderController = new TextEditingController();
    dobController = new TextEditingController();
    studentIdController = new TextEditingController();
    gstController = new TextEditingController();
    _apiResponse = new ApiResponse();
    isHide = true;
    cbRememberMe = false;
    userAutoValidate = false;
    autoValidationError = "";
    _userType = UserType.Student;
    fcmTokenMonitor();
    getUserId().then((value) {
      if (value != null) {
        _userId = value;
        getProfileData(userId: value);
      }
    });
    getDeviceToken().then((value) => deviceToken = value);
    getDeviceModel().then((value) => deviceModel = value);
    getDeviceVersion().then((value) => deviceVersion = value);
  }

  Future<SignUpModel> getUserSignUp({
    required String name,
    required String email,
    required String password,
    required String mobile,
    String? deviceToken,
    String? version,
    String? model,
  }) async {
    try {
      _signUpModel.requestStatus = RequestStatus.loading;
      notifyListeners();
      _signUpModel = await _userService.fetchUserSignUp(
        email: email,
        name: name,
        password: password,
        mobile: mobile,
        deviceToken: deviceToken != null ? deviceToken : await getDeviceToken(),
        model: model != null ? model : await getDeviceModel(),
        version: version != null ? version : await getDeviceVersion(),
      );
      notifyListeners();
    } on Failure catch (e) {
      _signUpModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _signUpModel;
  }

  Future<SignUpModel> getTrainerSignUp({
    required String name,
    required String email,
    required String password,
    required String mobile,
    String? deviceToken,
    String? version,
    String? model,
  }) async {
    try {
      _signUpModel.requestStatus = RequestStatus.loading;
      notifyListeners();
      _signUpModel = await _userService.fetchTrainerSignUp(
        email: email,
        name: name,
        password: password,
        mobile: mobile,
        deviceToken: deviceToken != null ? deviceToken : await getDeviceToken(),
        model: model != null ? model : await getDeviceModel(),
        version: version != null ? version : await getDeviceVersion(),
      );
      notifyListeners();
    } on Failure catch (e) {
      _signUpModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _signUpModel;
  }

  void setOtpStatus(OtpFor otpFor) {
    _otpFor = otpFor;
  }

  Future<void> setUserId(int? userId) async {
    _userId = userId;
    notifyListeners();
  }

  Future<ApiResponse> resendOtp() async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      notifyListeners();
      _apiResponse =
          await _userService.fetchResendOtp(mobile: mobileController.text);
      notifyListeners();
    } on Failure catch (e) {
      _apiResponse.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _apiResponse;
  }

  Future<SignUpModel> getUserLogin(
      {required String email,
      required String password,
      required String? deviceToken,
      required String? version,
      required String? model}) async {
    try {
      _signUpModel.requestStatus = RequestStatus.initial;
      _signUpModel = await _userService.fetchUserLogin(
        email: email,
        password: password,
        deviceToken: deviceToken,
        model: model,
        version: version,
      );
      notifyListeners();
    } on Failure catch (e) {
      _signUpModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _signUpModel;
  }

  Future<ProfileModel> getProfileData({required int userId}) async {
    try {
      _profileModel.requestStatus = RequestStatus.loading;
      _profileModel = await _userService.fetchProfileModel(userId: userId);
      notifyListeners();
    } on Failure catch (e) {
      _profileModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _profileModel;
  }

  Future<ProfileModel> getProfileDataUpdate(
      {required int userId,
      required String name,
      required String email,
      required String dob,
      required address,
      required String gender}) async {
    try {
      _profileModel.requestStatus = RequestStatus.loading;
      _profileModel = await _userService.fetchProfileDataUpdate(
          userId: userId,
          name: name,
          address: address,
          dob: dob,
          gender: gender,
          email: email);
      notifyListeners();
    } on Failure catch (e) {
      _profileModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _profileModel;
  }

  Future<bool> getProfilePicUpdate(
      {required int userId,
      required String filePath,
      required String fileName}) async {
    bool status = false;
    try {
      status = await _userService.fetchProfilePicUpdate(
          userId: userId, imagePath: filePath, imageName: fileName);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
    }
    return status;
  }

  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  Future<SignUpModel> getLoginWithOtp({required String mobile}) async {
    try {
      _signUpModel.requestStatus = RequestStatus.loading;
      notifyListeners();
      _signUpModel = await _userService.fetchLoginWithOtp(mobile: mobile);
      notifyListeners();
    } on Failure catch (e) {
      _signUpModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _signUpModel;
  }

  Future<SignUpModel> getVerifyLoginWithOtp(
      {required String otp, required String mobile}) async {
    try {
      _signUpModel.requestStatus = RequestStatus.loading;
      notifyListeners();
      _signUpModel =
          await _userService.fetchVerifyLoginWithOtp(mobile: mobile, otp: otp);
      notifyListeners();
    } on Failure catch (e) {
      _signUpModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _signUpModel;
  }

  Future<ApiResponse> getResendOtp({required String mobile}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      notifyListeners();
      _apiResponse = await _userService.fetchResendOtp(mobile: mobile);
      notifyListeners();
    } on Failure catch (e) {
      _apiResponse.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _apiResponse;
  }

  Future<ApiResponse> getSendOtp({required String mobile}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      notifyListeners();
      _apiResponse = await _userService.fetchSendOtp(mobile: mobile);
      notifyListeners();
    } on Failure catch (e) {
      _apiResponse.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _apiResponse;
  }

  Future<SignUpModel> getVerifyOtp(
      {required String mobile, required String otp}) async {
    try {
      _signUpModel.requestStatus = RequestStatus.loading;
      notifyListeners();
      _signUpModel =
          await _userService.fetchVerifyOtp(mobile: mobile, otp: otp);
      notifyListeners();
    } on Failure catch (e) {
      _signUpModel.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _signUpModel;
  }

  Future<ApiResponse> getResendEmailOtp({required String email}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      notifyListeners();
      _apiResponse = await _userService.fetchResendEmailOtp(email: email);
      notifyListeners();
    } on Failure catch (e) {
      _apiResponse.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _apiResponse;
  }

  Future<ApiResponse> getVerifyEmail(
      {required String otp, required String emailId}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      notifyListeners();
      _apiResponse = await _userService.fetchVerifyEmail(
        otp: otp,
        emailId: emailId,
      );
      notifyListeners();
    } on Failure catch (e) {
      _apiResponse.requestStatus = RequestStatus.failure;
      _setFailure(e);
    }
    return _apiResponse;
  }

  void keyBoardDismiss(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  bool formValidator(ValidationFor validationFor) {
    switch (validationFor) {
      case ValidationFor.Login:
        if (!isValidString(emailController.value.text) ||
            !RegExp(Validate.EMAIL_REGEX)
                .hasMatch(emailController.value.text)) {
          validationError = enter_user_email;
          userAutoValidate = false;
        } else if (!isValidString(passwordController.value.text)) {
          validationError = enter_user_password;
          userAutoValidate = false;
        } else {
          userAutoValidate = true;
        }
        break;
      case ValidationFor.SignUp:
        if (!isValidString(nameController.value.text)) {
          userAutoValidate = false;
          validationError = enter_user_name;
        } else if (!isValidString(emailController.value.text) ||
            !RegExp(Validate.EMAIL_REGEX)
                .hasMatch(emailController.value.text)) {
          userAutoValidate = false;
          validationError = enter_user_email;
        } else if (!isValidString(passwordController.value.text)) {
          userAutoValidate = false;
          validationError = enter_user_password;
        } else if (!cbRememberMe) {
          userAutoValidate = false;
          validationError = accept_policy;
        } else {
          userAutoValidate = true;
        }
        notifyListeners();
        break;
      case ValidationFor.Mobile:
        if (!isValidString(mobileController.value.text) ||
            mobileController.value.text.length < 10) {
          validationError = enter_user_mobile;
          userAutoValidate = false;
        } else {
          userAutoValidate = true;
        }
        notifyListeners();
        break;

      case ValidationFor.EditProfile:
        printLog("bhjnhbh", emailController.text);
        if (!isValidString(emailController.text) ||
            !RegExp(Validate.EMAIL_REGEX).hasMatch(emailController.text)) {
          userAutoValidate = false;
          validationError = enter_user_email;
        } else if (!isValidString(address1Controller.text) ||
            address1Controller.text.toString().trim().length < 2) {
          userAutoValidate = false;
          validationError = enter_user_address;
        } else if (!isValidString(nameController.text) ||
            nameController.text.toString().trim().length < 2 ||
            !RegExp(r'^[a-zA-Z ]+$').hasMatch(nameController.text)) {
          userAutoValidate = false;
          validationError = enter_user_name;
        } else if (!isValidString(genderController.text)) {
          userAutoValidate = false;
          validationError = select_gender;
        } else if (!isValidString(dobController.text) ||
            dobController.text.trim().length == 12) {
          userAutoValidate = false;
          validationError = enter_user_dob;
        } else {
          userAutoValidate = true;
        }
        notifyListeners();
        break;
      case ValidationFor.Attendance:
        if (!isValidString(studentIdController.text)) {
          userAutoValidate = false;
          validationError = enter_student_id;
        } else {
          userAutoValidate = true;
        }
        notifyListeners();
        break;
    }
    return userAutoValidate;
  }

  Future<void> getUserAccess() async {
    getUserType().then((value) {
      if (value != null && value == 3) {
        _userType = UserType.Trainer;
        notifyListeners();
      } else {
        _userType = UserType.Student;
      }
      notifyListeners();
    });
  }

  set validationError(String msg) {
    autoValidationError = msg;
    notifyListeners();
  }

  void setUserType(UserType userType) {
    _userType = userType;
    notifyListeners();
  }

  clearAllModels() {
    referController = new TextEditingController();
    emailController = new TextEditingController();
    nameController = new TextEditingController();
    passwordController = new TextEditingController();
    address1Controller = new TextEditingController();
    address2Controller = new TextEditingController();
    cityController = new TextEditingController();
    zipCodeController = new TextEditingController();
    stateController = new TextEditingController();
    mobileController = new TextEditingController();
    otpController = new TextEditingController();
    genderController = new TextEditingController();
    dobController = new TextEditingController();
    isHide = true;
    cbRememberMe = false;
    userAutoValidate = false;
    autoValidationError = "";
  }
}
