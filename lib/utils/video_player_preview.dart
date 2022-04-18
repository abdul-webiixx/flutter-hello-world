import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/main.dart';
import 'package:Zenith/screen/screen_controller.dart';
import 'package:Zenith/utils/widget_helper.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'custom_icons.dart';
import 'local_storage.dart';
import 'orientation/basic_overlay_widget.dart';

void videoPlayerDialog(BuildContext context, VideoPlayerController controller) {
  showGeneralDialog(
      barrierLabel: "label",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              height: 300,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.play_arrow_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Preview Video", style: styleProvider()),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.pause();
                            backToScreen(context);
                          },
                          child: Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(
                    height: 2,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Stack(
                      children: [
                        VideoPlayer(controller),
                        BasicOverlayWidget(
                          controller: controller,
                          isFullScreen: false,
                          thumbUrl: null,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      });
}

void signOutDialog(BuildContext context) {
  showGeneralDialog(
      barrierLabel: "label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              height: 180,
              decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(CustomIcons.logout),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Sign Out", style: styleProvider()),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Divider(
                    height: 2,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  SizedBox(height: 15),
                  Text("Are you sure you would like to sign out?",
                      style: styleProvider(
                        size: 12,
                      )),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonTransparent(
                          onPressed: () {
                            backToScreen(context);
                          },
                          title: "NO",
                          color: Theme.of(context).primaryColorLight,
                          width: MediaQuery.of(context).size.width / 2 - 50,
                        ),
                        CustomButton(
                          onPressed: () {
                            BasePrefs.clearPrefs();
                            changeToNewScreen(
                                context, ScreensController(), "/");
                          },
                          title: "YES",
                          width: MediaQuery.of(context).size.width / 2 - 50,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      });
}

Widget animatedToggleButton(BuildContext context,
    {Key? key, required bool status, required GestureTapCallback onClick}) {
  return AnimatedContainer(
    key: key,
    duration: Duration(milliseconds: 1000),
    height: 20,
    width: 45,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: status
            ? Theme.of(context).primaryColor
            : Theme.of(context).highlightColor),
    child: Stack(
      children: <Widget>[
        AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            right: status ? 0.0 : 20.0,
            left: status ? 20.0 : 0.0,
            child: InkWell(
              focusColor: Theme.of(context).primaryColorLight,
              onTap: onClick,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(child: child, scale: animation);
                },
                child: status
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: Theme.of(context).backgroundColor,
                        size: 20,
                      )
                    : Icon(
                        Icons.remove_circle,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
              ),
            ))
      ],
    ),
  );
}
