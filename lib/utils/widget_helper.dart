import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/size_config.dart';

import 'custom_icons.dart';

Widget streamWidget(BuildContext context) {
  return Stack(
    children: [
      Container(
        width: 50,
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Icon(
              CustomIcons.live_streaming,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
      ),
      Container(
        width: 40,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.amber[600]!, Colors.amber[400]!]),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          Icons.play_arrow_sharp,
          size: 20,
          color: white,
        ),
      ),
    ],
  );
}

Widget circularImageView(
    {double? elevation,
    double? radius,
    String? imageUrl,
    Function? onCallback}) {
  return Card(
    elevation: 10,
    shape: CircleBorder(side: BorderSide.none),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: radius != null ? radius : 50.0,
        backgroundImage: NetworkImage(imageUrl!),
        backgroundColor: Colors.black,
      ),
    ),
  );
}

class LoadingView extends StatelessWidget {
  final String? msg;
  LoadingView({Key? key, this.msg}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor, strokeWidth: 3),
              ),
              Text(
                '${msg ?? "Loading..."}',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ]));
  }
}

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String title;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? containerPadding;
  final double radius;
  final double? width;

  CustomButton(
      {@required this.onPressed,
      required this.title,
      this.color,
      this.padding,
      this.width,
      this.containerPadding,
      this.radius = 15});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: padding != null ? padding : EdgeInsets.all(3),
        splashColor: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        child: Container(
          width: width != null ? width : SizeConfig.screenWidth!,
          padding: containerPadding != null
              ? containerPadding
              : EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFFFFAE00),
                  Color(0xFFFFAE00),
                  Color(0xFFF9E866),
                ],
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Text(title,
              textAlign: TextAlign.center,
              style: styleProvider(
                  fontWeight: semiBold,
                  size: 14,
                  color: Theme.of(context).backgroundColor)),
        ),
        onPressed: onPressed);
  }
}

class CustomButtonTransparent extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final Color color;
  final double radius;
  final EdgeInsets? padding;
  final double? width;
  CustomButtonTransparent(
      {@required this.onPressed,
      this.title,
      this.color = white,
      this.padding,
      this.width,
      this.radius = 10});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: padding != null ? padding : EdgeInsets.all(3),
      splashColor: Theme.of(context).primaryColor,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Container(
        width: width != null ? width : SizeConfig.screenWidth!,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Text(
          title!,
          textAlign: TextAlign.center,
          style: styleProvider(fontWeight: semiBold, size: 14, color: color),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

TextStyle styleProvider(
    {FontWeight? fontWeight,
    double? size,
    Color? color,
    double? height,
    FontStyle? fontStyle}) {
  return TextStyle(
    fontFamily: fontName,
    fontWeight: fontWeight != null ? fontWeight : medium,
    fontSize: size != null ? size : 14,
    fontStyle: fontStyle != null ? fontStyle : FontStyle.normal,
    color: color != null ? color : Colors.white,
  );
}

Widget progressBar(BuildContext context, Color color) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: new AlwaysStoppedAnimation<Color>(color),
      )
    ],
  ));
}
