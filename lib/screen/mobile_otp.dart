import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/utils/enum.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/user_view_model.dart';

import 'otp_verification.dart';

class MobileOtpScreen extends StatefulWidget {
  @override
  _MobileOtpScreenState createState() => _MobileOtpScreenState();
}

class _MobileOtpScreenState extends State<MobileOtpScreen> {
  late FirebaseService _firebaseService;
  @override
  void initState() {
    _firebaseService = new FirebaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(builder: (context, model, child) {
      return Scaffold(
          appBar: BaseAppBar(
            isLeading: true,
          ),
          body: Stack(
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sign in with OTP",
                      style: TextStyle(fontWeight: medium, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      otp_text_code,
                      style: TextStyle(
                          fontWeight: regular,
                          fontSize: 14,
                          color: Theme.of(context).hintColor),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 45,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Image.network(indian_flag),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 35,
                          width: SizeConfig.screenWidth! - 110,
                          decoration: BoxDecoration(
                            color: Theme.of(context).highlightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                color: darkBlack,
                                child: Text(
                                  "+91",
                                  style: styleProvider(size: 16),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 200,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: ""),
                                  controller: model.mobileController,
                                  keyboardType: TextInputType.phone,
                                  style: styleProvider(size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        model.keyBoardDismiss(context);
                        if (model.formValidator(ValidationFor.Mobile)) {
                          model.state = ViewState.Busy;
                          switch (model.otpFor) {
                            case OtpFor.ForgotPassword:
                              model
                                  .getLoginWithOtp(
                                      mobile: model.mobileController.text)
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null && value.success) {
                                  changeScreen(
                                      context, OtpVerificationScreen());
                                }
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "fetchLoginWithOtp",
                                    stackTrace: stackTrace,
                                    userId: model.mobileController.text,
                                    message: error.toString());
                              });
                              break;
                            case OtpFor.Login:
                              model
                                  .getLoginWithOtp(
                                      mobile: model.mobileController.text)
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null && value.success) {
                                  changeScreen(
                                      context, OtpVerificationScreen());
                                }
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "fetchLoginWithOtp",
                                    stackTrace: stackTrace,
                                    userId: model.mobileController.text,
                                    message: error.toString());
                              });
                              break;
                            case OtpFor.SignUp:
                            case OtpFor.Email:
                              model
                                  .getSendOtp(
                                      mobile: model.mobileController.text)
                                  .then((value) {
                                model.state = ViewState.Idle;
                                showToast(context, msg: value.message!);
                                if (value.success != null && value.success) {
                                  changeScreen(
                                      context, OtpVerificationScreen());
                                }
                              }).onError((error, stackTrace) {
                                model.state = ViewState.Idle;
                                _firebaseService.firebaseJsonError(
                                    apiCall: "fetchOtp",
                                    stackTrace: stackTrace,
                                    userId: model.mobileController.text,
                                    message: error.toString());
                              });
                              break;
                          }
                        } else {
                          showToast(context,
                              msg: model.autoValidationError!,
                              bgColor: Theme.of(context).errorColor);
                        }
                      },
                      title: "SEND OTP",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      otp_text_terms,
                      style: TextStyle(
                          fontWeight: regular,
                          fontSize: 14,
                          color: Theme.of(context).hintColor),
                      textAlign: TextAlign.center,
                    ),
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
}
