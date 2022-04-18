import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/mobile_otp.dart';
import 'package:Zenith/screen/policy.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/user_view_model.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(builder: (context, model, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          labelText: "Name",
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
                        keyboardType: TextInputType.name,
                        controller: model.nameController,
                        style: styleProvider(
                            fontWeight: regular,
                            color: Theme.of(context).primaryColorLight,
                            size: 14),
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
                        controller: model.passwordController,
                        obscureText: model.isHide,
                        style: styleProvider(
                            fontWeight: regular,
                            color: Theme.of(context).primaryColorLight,
                            size: 14),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20.0,
                              width: 20.0,
                              child: GestureDetector(
                                child: Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: Colors.white),
                                  child: Checkbox(
                                    value: model.cbRememberMe,
                                    checkColor:
                                        Theme.of(context).backgroundColor,
                                    activeColor: Theme.of(context).primaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        model.cbRememberMe = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Container(
                              width: SizeConfig.screenWidth! - 80,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: RichText(
                                    text: TextSpan(
                                        text:
                                            "By signing up you will agree to our",
                                        style: styleProvider(
                                            fontWeight: thin, size: 12),
                                        children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              changeScreen(
                                                  context,
                                                  PolicyScreen(
                                                      requestFor:
                                                          PolicyRequestFor
                                                              .PrivacyPolicy));
                                            },
                                          text: " Privacy Policy \n",
                                          style: styleProvider(
                                              fontWeight: regular,
                                              size: 12,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          text: "And",
                                          style: styleProvider(
                                              fontWeight: thin,
                                              size: 12,
                                              color: Theme.of(context)
                                                  .primaryColorLight)),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              changeScreen(
                                                  context,
                                                  PolicyScreen(
                                                      requestFor:
                                                          PolicyRequestFor
                                                              .TermsAndUse));
                                            },
                                          text: " Terms",
                                          style: styleProvider(
                                              fontWeight: regular,
                                              size: 12,
                                              color: Theme.of(context)
                                                  .primaryColor))
                                    ])),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () async {
                          model.keyBoardDismiss(context);
                          if (model.formValidator(ValidationFor.SignUp)) {
                            model.setOtpStatus(OtpFor.SignUp);
                            changeScreen(context, MobileOtpScreen());
                          } else {
                            showToast(context,
                                msg: model.autoValidationError!,
                                bgColor: Theme.of(context).errorColor);
                          }
                        },
                        title: "Sign Up",
                      )
                    ],
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
          ));
    });
  }
}
