import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/screen/splash.dart';
import 'package:Zenith/utils/local_storage.dart';
import 'package:Zenith/utils/widget_helper.dart';

class SomethingWentWrong extends StatelessWidget {
  final ResponseStatus status;
  final String? message;
  SomethingWentWrong({Key? key, required this.status, this.message})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(ic_warning),
                    Text(
                      titlePrinter(status),
                      textAlign: TextAlign.center,
                      style: styleProvider(size: 18, fontWeight: semiBold),
                    ),
                    Text(
                      msgPrinter(status),
                      style: styleProvider(
                          size: 12,
                          fontWeight: semiBold,
                          color: Theme.of(context).hintColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () => callBack(status, context),
                title: buttonPrinter(status),
              )
            ],
          ),
        ),
      ),
    );
  }

  String msgPrinter(ResponseStatus status) {
    String msg = network_error;
    switch (status) {
      case ResponseStatus.server:
        msg = request_error_msg;
        break;
      case ResponseStatus.unauthorized:
        msg = authentication_failed;
        break;
      case ResponseStatus.network:
        msg = internet_connection_error;
        break;
      case ResponseStatus.failed:
        msg = message != null ? message! : ConnectionRequestFailed;
        break;
    }
    return msg;
  }

  String titlePrinter(ResponseStatus status) {
    String msg = network_error;
    switch (status) {
      case ResponseStatus.server:
        msg = request_error_msg;
        break;
      case ResponseStatus.unauthorized:
        msg = "Authentication Failed";
        break;
      case ResponseStatus.network:
        msg = "No Internet Connection";
        break;
      case ResponseStatus.failed:
        msg = "Request failed";
        break;
    }
    return msg;
  }

  void callBack(ResponseStatus status, BuildContext context) {
    switch (status) {
      case ResponseStatus.server:
        backToPhone();
        break;
      case ResponseStatus.unauthorized:
        BasePrefs.clearPrefs();
        Future.delayed(const Duration(milliseconds: 1000), () {
          changeToNewScreen(context, InitialScreen(), "/initial");
        });
        break;
      case ResponseStatus.network:
        changeScreen(
            context,
            MainScreen(
              currentTab: 0,
            ));
        break;
      case ResponseStatus.failed:
        changeScreen(
            context,
            MainScreen(
              currentTab: 0,
            ));
        break;
    }
  }

  String buttonPrinter(ResponseStatus status) {
    if (status == ResponseStatus.server) {
      return "Close";
    } else if (status == ResponseStatus.unauthorized) {
      return "Authenticate";
    } else {
      return "Go Back";
    }
  }
}

class DataNotFound extends StatelessWidget {
  final bool? isButton;
  final bool? noIcon;
  final String? title;
  final String? subTitle;
  final UserType? userType;
  DataNotFound(
      {Key? key,
      this.title,
      this.noIcon,
      this.subTitle,
      this.isButton,
      this.userType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 20),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    userType != null && userType == UserType.Trainer
                        ? title!
                        : "Data Not Available",
                    textAlign: TextAlign.center,
                    style: styleProvider(size: 18, fontWeight: semiBold),
                  ),
                  Text(
                    userType != null && userType == UserType.Trainer
                        ? subTitle!
                        : "There is no data to show you right now",
                    style: styleProvider(
                        size: 12,
                        fontWeight: semiBold,
                        color: Theme.of(context).hintColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            isButton != null && isButton!
                ? CustomButton(
                    onPressed: () {
                      changeScreen(
                          context,
                          MainScreen(
                            currentTab: 0,
                          ));
                    },
                    title: "Go Home",
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class CartEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          decoration: BoxDecoration(
            color: Theme.of(context).highlightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                "Your Cart is Empty",
                textAlign: TextAlign.center,
                style: styleProvider(size: 18, fontWeight: semiBold),
              ),
              Text(
                "Click here to see our courses.",
                style: styleProvider(
                    size: 12,
                    fontWeight: semiBold,
                    color: Theme.of(context).hintColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {
                  changeScreen(
                      context,
                      MainScreen(
                        currentTab: 0,
                      ));
                },
                title: "Continue",
              )
            ],
          ),
        ),
      ],
    );
  }
}
