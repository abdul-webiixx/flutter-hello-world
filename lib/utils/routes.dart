import 'package:flutter/material.dart';
import 'package:Zenith/screen/home.dart';
import 'package:Zenith/screen/login_signUp.dart';
import 'package:Zenith/screen/screen_controller.dart';
import 'package:Zenith/screen/splash.dart';

class RouteName {
  static const String ScreenController = "/";
  static const String LoginSignUp = "LoginSignUp";
  static const String Initial = "Initial";
  static const String Home = "HOME";

}
class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.ScreenController:
        return MaterialPageRoute(builder: (context) => ScreensController());
      case RouteName.Initial:
        return MaterialPageRoute(builder: (_) => InitialScreen());
      case RouteName.Home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteName.LoginSignUp:
        return MaterialPageRoute(builder: (_) => LoginSignUpScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
//                  Image.asset('assets/images/error.jpg'),
                  Text(
                    "${settings.name} does not exists!",
                    style: TextStyle(fontSize: 24.0),
                  )
                ],
              ),
            ),
          ),
        );
    }
  }
}