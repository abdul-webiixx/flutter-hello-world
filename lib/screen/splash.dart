import 'package:Zenith/base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/login_signUp.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/user_view_model.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(
        fullScreen: true,
        builder: (context, model, child){
      return Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [_bgSplash(), _header(), _footer(model)],
        ),
      );
    });
  }

  Widget _bgSplash() {
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: new AssetImage(
              ic_bg_splash),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _header() {
    return new Align(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(bottom: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ic_logo, height: 150, width: 150,),
              Text(
                "Wanna Dance\nWe Make it Simple",
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    color: white,
                    fontSize: 25,
                    height: 1,
                    fontFamily: fontName,
                    fontWeight: medium),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: 50,
                child: Divider(
                  color: white,
                  thickness: 0.5,
                ),
              ),
              Text("Comment to start a discussion,\n make a note, or annotate the artboard.",
                textAlign: TextAlign.center,style: TextStyle(
                    decoration: TextDecoration.none,
                    color: grey,
                    fontSize: 10,
                    height: 1,
                    fontFamily: fontName,
                    fontWeight: medium),
              )
            ],
          ),
        ));
  }

  Widget _footer(UserViewModel _userViewModel){
    return new Positioned(
      bottom: 0,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomButton(onPressed: (){
                  _userViewModel.setUserType(UserType.Trainer);
                  changeScreen(context, LoginSignUpScreen());
            }, title: "JOIN AS TRAINER"),
            SizedBox(height: 10,),
            CustomButtonTransparent(onPressed: (){
              _userViewModel.setUserType(UserType.Student);
              changeScreen(context, LoginSignUpScreen());
            }, title: "JOIN AS STUDENT")
          ],
        ),
      ),
    );
  }
}

