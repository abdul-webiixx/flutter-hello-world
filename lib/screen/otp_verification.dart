import 'dart:async';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/screen/instructor_home.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/local_storage.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/user_view_model.dart';

import 'thank_you.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  var onTapRecognizer;
  StreamController<ErrorAnimationType>? errorController;
  late String pinCode;
  bool hasError = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  late FirebaseService _firebaseService;

  @override
  void dispose() {
    super.dispose();
    if (errorController != null) {
      errorController!.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(onModelReady: (model, userId, userType) {
      model.otpController = new TextEditingController();
      onTapRecognizer = TapGestureRecognizer()
        ..onTap = () {
          Navigator.pop(context);
        };
      errorController = StreamController<ErrorAnimationType>();
      _firebaseService = new FirebaseService();
      _firebaseService = new FirebaseService();
      errorController = StreamController<ErrorAnimationType>();
    }, builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          appBar: BaseAppBar(
            isLeading: true,
          ),
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(
                  horizontal: 33,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Verification",
                      style: TextStyle(fontWeight: medium, fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Enter your OTP code here",
                        style: TextStyle(
                            fontWeight: regular,
                            fontSize: 14,
                            color: Theme.of(context).hintColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            length: 4,
                            obscureText: false,
                            textStyle: styleProvider(
                                color: black, fontWeight: bold, size: 18),
                            obscuringCharacter: '*',
                            blinkWhenObscuring: true,
                            animationType: AnimationType.fade,
                            validator: (v) {
                              if (v != null && v.isNotEmpty && v.length < 3) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 60,
                              fieldWidth: 45,
                              inactiveColor: Theme.of(context).highlightColor,
                              inactiveFillColor:
                                  Theme.of(context).highlightColor,
                              selectedFillColor: Theme.of(context).primaryColor,
                              selectedColor: Theme.of(context).primaryColor,
                              activeFillColor: Theme.of(context).primaryColor,
                              activeColor: Theme.of(context).primaryColor,
                            ),
                            cursorColor: Colors.black,
                            animationDuration: Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: model.otpController,
                            keyboardType: TextInputType.number,
                            boxShadows: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                color: Colors.black12,
                                blurRadius: 10,
                              )
                            ],
                            onCompleted: (v) {
                              pinCode = v;
                            },
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          ),
                        )),
                    Text(
                      "Didn't you receive any code?",
                      style: TextStyle(
                          fontWeight: regular,
                          fontSize: 14,
                          color: Theme.of(context).hintColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        model.state = ViewState.Busy;
                        model.keyBoardDismiss(context);
                        switch (model.otpFor) {
                          case OtpFor.Email:
                            model
                                .getResendEmailOtp(
                                    email: model.emailController.text)
                                .then((value) {
                              model.state = ViewState.Idle;
                              showToast(context, msg: value.message!);
                            });
                            break;
                          case OtpFor.ForgotPassword:
                          case OtpFor.Login:
                          case OtpFor.SignUp:
                            model.resendOtp().then((value) {
                              model.state = ViewState.Idle;
                              showToast(context, msg: value.message!);
                            });
                            break;
                        }
                      },
                      child: Text(
                        "RESEND NEW CODE",
                        style: TextStyle(
                            fontWeight: regular,
                            fontSize: 14,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      onPressed: () async {
                        if (pinCode.isNotEmpty) {
                          model.state = ViewState.Busy;
                          model.keyBoardDismiss(context);
                          switch (model.otpFor) {
                            case OtpFor.Login:
                              model
                                  .getVerifyLoginWithOtp(
                                      otp: pinCode,
                                      mobile: model.mobileController.text)
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null &&
                                    value.success! &&
                                    value.data != null) {
                                  if (value.data!.userInformation!.roleId ==
                                      3) {
                                    goToHomePage(
                                        value, InstructorHomeScreen(), model);
                                  } else {
                                    goToHomePage(
                                        value,
                                        MainScreen(
                                          currentTab: 0,
                                        ),
                                        model);
                                  }
                                }
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "fetchVerifyLoginWithOtp",
                                    stackTrace: stackTrace,
                                    userId: model.mobileController.text,
                                    message: error.toString());
                              });
                              break;
                            case OtpFor.ForgotPassword:
                              model
                                  .getVerifyLoginWithOtp(
                                      otp: pinCode,
                                      mobile: model.mobileController.text)
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null &&
                                    value.success! &&
                                    value.data != null) {
                                  goToHomePage(
                                      value, MainScreen(currentTab: 0), model);
                                }
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "fetchVerifyLoginWithOtp",
                                    stackTrace: stackTrace,
                                    userId: model.mobileController.text,
                                    message: error.toString());
                              });
                              break;
                            case OtpFor.SignUp:
                              model
                                  .getVerifyOtp(
                                      otp: pinCode,
                                      mobile: model.mobileController.text)
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null && value.success!) {
                                  model.state = ViewState.Busy;
                                  switch (model.userType) {
                                    case UserType.Trainer:
                                      model
                                          .getTrainerSignUp(
                                              name: model.nameController.text
                                                  .trim(),
                                              email: model.emailController.text
                                                  .trim(),
                                              password: model
                                                  .passwordController.text
                                                  .trim(),
                                              mobile: model
                                                  .mobileController.text
                                                  .trim())
                                          .then((signUpData) {
                                        model.state = ViewState.Idle;
                                        showToast(context,
                                            msg: signUpData.message!);
                                        if (signUpData.success != null &&
                                            signUpData.success! &&
                                            signUpData.data != null) {
                                          changeToNewScreen(
                                              context,
                                              ThanksYouScreen(
                                                thanksFor: ThanksFor.SignUp,
                                              ),
                                              "/thankYou");
                                        }
                                      }).onError((error, stackTrace) {
                                        model.state = ViewState.Idle;
                                      });
                                      break;
                                    case UserType.Student:
                                      model
                                          .getUserSignUp(
                                              name: model.nameController.text
                                                  .trim(),
                                              email: model.emailController.text
                                                  .trim(),
                                              password: model
                                                  .passwordController.text
                                                  .trim(),
                                              mobile: model
                                                  .mobileController.text
                                                  .trim())
                                          .then((signUpData) {
                                        model.state = ViewState.Idle;
                                        showToast(context,
                                            msg: signUpData.message!);
                                        if (signUpData.success != null &&
                                            signUpData.success! &&
                                            signUpData.data != null) {
                                          goToHomePage(
                                              signUpData,
                                              MainScreen(
                                                currentTab: 0,
                                              ),
                                              model);
                                        }
                                      }).onError((error, stackTrace) {
                                        model.state = ViewState.Idle;
                                      });
                                      break;
                                  }
                                }
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "verifyOtp",
                                    stackTrace: stackTrace,
                                    userId: model.mobileController.text,
                                    message: error.toString());
                              });
                              break;
                            case OtpFor.Email:
                              model
                                  .getVerifyEmail(
                                      otp: pinCode,
                                      emailId: model.emailController.text
                                          .toString()
                                          .trim())
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null && value.success) {
                                  changeScreen(
                                      context,
                                      MainScreen(
                                        currentTab: 0,
                                      ));
                                } else {}
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "fetchVerifyEmail",
                                    stackTrace: stackTrace,
                                    userId: model.emailController.text,
                                    message: error.toString());
                              });
                              break;
                          }
                        } else {
                          showToast(context, msg: enter_otp);
                        }
                      },
                      title: "Verify OTP",
                    )
                  ],
                ),
              ),
              model.state == ViewState.Busy
                  ? new Align(
                      alignment: Alignment.center,
                      child: LoadingView(),
                    )
                  : Container(),
            ],
          ));
    });
  }

  void goToHomePage(SignUpModel value, Widget widget, UserViewModel model) {
    showToast(context, msg: value.message!);
    if (value.success != null || value.success! && value.data != null) {
      BasePrefs.saveData(userId, value.data!.userInformation!.id!);
      BasePrefs.saveData(authToken, value.data!.token!);
      BasePrefs.saveData(userType, value.data!.userInformation!.roleId!);
      model.setUserId(value.data!.userInformation!.id!);
      AppViewModel.initializer();
      changeToNewScreen(context, widget, "\main");
    }
  }
}
