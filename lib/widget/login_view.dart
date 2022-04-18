import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/validator/validate.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/instructor_home.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/screen/mobile_otp.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/local_storage.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/user_view_model.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  late FirebaseService _firebaseService;
  @override
  void initState() {
    _firebaseService = new FirebaseService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(builder: (context, model, child) {
      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        suffix: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.check,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        labelText: "Email Address",
                        labelStyle: styleProvider(
                            fontWeight: medium,
                            size: 14,
                            color: Theme.of(context).hintColor),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: model.emailController,
                      style: styleProvider(
                          fontWeight: regular,
                          color: Theme.of(context).primaryColorLight,
                          size: 14),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        suffix: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                model.isHide
                                    ? CustomIcons.eye_off
                                    : CustomIcons.eye_on,
                                size: 20,
                                color: model.isHide
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).hintColor,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                model.isHide = !model.isHide;
                              });
                            }),
                        labelText: "Password",
                        labelStyle: styleProvider(
                            fontWeight: medium,
                            size: 14,
                            color: Theme.of(context).hintColor),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).hintColor),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: model.isHide,
                      controller: model.passwordController,
                      style: styleProvider(
                          fontWeight: regular,
                          color: Theme.of(context).primaryColorLight,
                          size: 14),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.only(top: 0),
                      onPressed: () {
                        changeScreen(context, MobileOtpScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: styleProvider(fontWeight: regular, size: 12),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () async {
                        model.state = ViewState.Busy;
                        model.keyBoardDismiss(context);
                        if (model.formValidator(ValidationFor.Login)) {
                          model
                              .getUserLogin(
                                  email: model.emailController.text.trim(),
                                  password:
                                      model.passwordController.text.trim(),
                                  deviceToken: model.deviceToken,
                                  model: isValidString(model.deviceModel)
                                      ? model.deviceModel
                                      : await getDeviceToken(),
                                  version: model.deviceVersion)
                              .then((value) {
                            model.state = ViewState.Idle;
                            showToast(context, msg: value.message!);
                            if (value.requestStatus == RequestStatus.loaded &&
                                value.success) {
                              BasePrefs.saveData(authToken, value.data!.token);
                              BasePrefs.saveData(
                                  userId, value.data!.userInformation!.id);
                              model.clearAllModels();
                              if (value.data != null &&
                                  value.data!.userInformation != null &&
                                  value.data!.userInformation!.roleId != null &&
                                  value.data!.userInformation!.roleId == 3) {
                                BasePrefs.saveData(userType,
                                    value.data!.userInformation!.roleId!);
                                model
                                    .setUserId(value.data!.userInformation!.id);
                                changeToNewScreen(context,
                                    InstructorHomeScreen(), "/instructor_home");
                              } else {
                                changeToNewScreen(context,
                                    MainScreen(currentTab: 0), "/main");
                              }
                            }
                          }).onError((error, stackTrace) {
                            model.state = ViewState.Idle;
                            _firebaseService.firebaseJsonError(
                                apiCall: "fetchUserLogin",
                                stackTrace: stackTrace,
                                message: error.toString(),
                                userId: null);
                            showToast(context, msg: error.toString());
                          });
                        } else {
                          showToast(context,
                              msg: model.autoValidationError!,
                              bgColor: Theme.of(context).errorColor);
                        }
                      },
                      title: "LOGIN",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomButtonTransparent(
                      onPressed: () {
                        model.setOtpStatus(OtpFor.Login);
                        changeScreen(
                          context,
                          MobileOtpScreen(),
                        );
                      },
                      title: "LOGIN WITH OTP",
                    )
                  ],
                ),
              ),
            ),
          ),
          model.state == ViewState.Busy
              ? new Align(
                  alignment: Alignment.center,
                  child: LoadingView(),
                )
              : Container(),
        ],
      );
    });
  }
}
