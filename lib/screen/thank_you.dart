import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/screen_controller.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class ThanksYouScreen extends StatelessWidget {
  final ThanksFor thanksFor;
  const ThanksYouScreen({Key? key, required this.thanksFor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
    return WillPopScope(
        onWillPop: ()async{
          if(i==0){
            i++;
            showToast(context, msg:"tap again to exit");
            return false;
          }else if(thanksFor == ThanksFor.Purchase){
            changeToNewScreen(context, ScreensController(), "/main");
          }else {
            backToPhone();
          }

          return true;
        },
      child:  Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        appBar: BaseAppBar(),
        body: Container(
          color: Theme.of(context).backgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: 200,
                child: Text(
                  headingTitle(thanksFor),
                  textAlign: TextAlign.center,
                  style: styleProvider(size: 16, fontWeight: medium),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              pageBody(thanksFor),
              SizedBox(height: 20,),
              thanksFor== ThanksFor.Purchase ? CustomButton(onPressed: (){
                changeScreen(context, MainScreen(currentTab: 0));
              }, title: "Continue"): pageFooter(context, thanksFor)
            ],
          ),
        ),
      ),
    ),);
  }
}
String headingTitle(ThanksFor thanksFor){
  switch(thanksFor){
    case ThanksFor.Purchase:
     return "Thank you for being our customer";
    case ThanksFor.SignUp:
      return "Thank you for Signup";
  }
}
Widget pageBody(ThanksFor thanksFor){
  switch(thanksFor){
    case ThanksFor.Purchase:
      return Image.asset(ic_thank_you);
    case ThanksFor.SignUp:
      return Container();
  }
}

Widget pageFooter(BuildContext context, ThanksFor thanksFor){
  switch(thanksFor){
    case ThanksFor.Purchase:
      return Image.asset(ic_thank_you);
    case ThanksFor.SignUp:
      return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Column(
          children: [
            Image.asset(ic_thankYou_signUp),
            Text("This account is in review, We will notify you once approved by admin",
              textAlign: TextAlign.center,
              style: styleProvider(
                size: 12,
                fontWeight: regular,
                color: grey
              ),)
          ],
        ),
      );
  }
}

