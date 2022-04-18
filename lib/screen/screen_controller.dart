import 'dart:async';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/auth_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/instructor_home.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/screen/splash.dart';

class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  startTime(UserStatus? userStatus, UserType? userType) async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, () {
      if (userType == UserType.Trainer) {
        animationController = new AnimationController(
            vsync: this, duration: new Duration(seconds: 2));
        animation = new CurvedAnimation(
            parent: animationController!, curve: Curves.easeOut);

        animation!.addListener(() => this.setState(() {}));
        animationController!.forward();
        if (userStatus == UserStatus.Authorized) {
          changeToNewScreen(context, InstructorHomeScreen(), "/instructor");
        } else {
          changeToNewScreen(context, InitialScreen(), "/initial");
        }
      } else {
        if (userStatus == UserStatus.Authorized) {
          changeToNewScreen(context, MainScreen(currentTab: 0), "/main");
        } else {
          changeToNewScreen(context, InitialScreen(), "/initial");
        }
      }
    });
  }

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController!, curve: Curves.easeOut);
    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        authRequired: true,
        onModelReady: (model, userId, userType) async {
          startTime(
              await userId != null
                  ? UserStatus.Authorized
                  : UserStatus.Unauthorized,
              await userType);
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      ic_logo,
                      width: animation!.value * 150,
                      height: animation!.value * 150,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
