import 'package:flutter/material.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

import 'toast.dart';

class LoadingProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      color: Colors.transparent,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      ),
    );
  }
}

void showToast(BuildContext context,
    {required String msg,
    int? gravity,
    Color? color,
    Color? bgColor,
    int? duration,
    TextStyle? textStyle}) {
  return Toast.show(
    msg,
    context,
    gravity: gravity != null ? gravity : Toast.bottom,
    textStyle: textStyle ?? styleProvider(),
    duration: duration,
    backgroundColor:
        bgColor != null ? bgColor : Theme.of(context).highlightColor,
  );
}

void printLog(String tag, Object msg) {
  debugPrint(tag + " => " + msg.toString());
}

ResponseStatus getResponse(RequestStatus status) {
  if (status == RequestStatus.unauthorized) {
    return ResponseStatus.unauthorized;
  } else if (status == RequestStatus.server) {
    return ResponseStatus.server;
  } else if (status == RequestStatus.failure) {
    return ResponseStatus.failed;
  } else {
    return ResponseStatus.network;
  }
}
