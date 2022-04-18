import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/services/app.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/screen/class.dart';
import 'package:Zenith/screen/course.dart';
import 'package:Zenith/screen/home.dart';
import 'package:Zenith/screen/notification.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/widget_helper.dart';

class MainScreen extends StatefulWidget {
  final int currentTab;
  MainScreen({Key? key, required this.currentTab}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageStorageBucket bucket = PageStorageBucket();
  AppService _appService = AppService();
  int currentTab = 0;
  @override
  void initState() {
    currentTab = widget.currentTab;
    getUserId().then((valueid) {
      _appService.fetchHome(userId: valueid!).then((value) {
        Future.delayed(
            Duration(seconds: 3), () => showPopUpAd(homeModel: value));
      });
    });

    super.initState();
  }

  bool isClicked = false;
  showPopUpAd({required HomeModel homeModel}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                homeModel.homeData!.advertisement!.title!,
                style: styleProvider(),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            CachedNetworkImage(
              imageUrl:
                  "${homeModel.storagePath}${homeModel.homeData!.advertisement!.cover}",
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Image.asset(
                moke_image2,
              ),
            )
          ],
        ),
        contentPadding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 16.0),
        titlePadding: const EdgeInsets.all(2.0),
        content: Text(
          homeModel.homeData!.advertisement!.description!,
          textAlign: TextAlign.center,
          style: styleProvider(size: 10, color: grey),
        ),
        actions: <Widget>[
          CustomButton(
            title: 'OK',
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
        fullScreen: true,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            body: getBody(),
            bottomNavigationBar: BottomAppBar(
              color: Theme.of(context).backgroundColor,
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        setState(() {
                          currentTab = 0;
                          // currentScreen(0);
                        });
                      },
                      child: Icon(
                        CustomIcons.home,
                        color: currentTab != 0
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        setState(() {
                          currentTab = 1;
                          // currentScreen(1);
                        });
                      },
                      child: Icon(
                        CustomIcons.courses,
                        color: currentTab != 1
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    MaterialButton(
                      minWidth: 50,
                      onPressed: () {
                        setState(() {
                          currentTab = 2;
                          // currentScreen(2);
                        });
                      },
                      child: Icon(
                        CustomIcons.live_streaming,
                        color: currentTab != 2
                            ? Theme.of(context).primaryColorLight
                            : Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    MaterialButton(
                        minWidth: 50,
                        onPressed: () {
                          setState(() {
                            currentTab = 3;
                            isClicked = true;
                          });
                          getUserId().then((value) {
                            if (value != null) {
                              model.getNotificationStatus(userId: value);
                            }
                          });
                        },
                        child: model.notificationModel.status != null &&
                                model.notificationModel.status!.unchecked !=
                                    null &&
                                model.notificationModel.status!.unchecked! > 0
                            ? Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Icon(
                                      CustomIcons.notification,
                                      color: currentTab != 4
                                          ? Theme.of(context).primaryColorLight
                                          : Theme.of(context).primaryColor,
                                      size: 20,
                                    ),
                                    new Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              color: Colors.pink[200],
                                              shape: BoxShape.circle),
                                          child: Text(
                                            "${model.notificationModel.status!.unchecked}",
                                            style: styleProvider(
                                                size: 5,
                                                color: white,
                                                fontWeight: bold),
                                          ),
                                        ))
                                  ],
                                ),
                              )
                            : Icon(
                                CustomIcons.notification,
                                color: currentTab != 4
                                    ? Theme.of(context).primaryColorLight
                                    : Theme.of(context).primaryColor,
                                size: 20,
                              )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget getBody() {
    List<Widget> pages = [
      HomeScreen(),
      CourseScreen(),
      ClassScreen(),
      NotificationScreen()
    ];
    return IndexedStack(
      index: currentTab,
      children: pages,
    );
  }
}
