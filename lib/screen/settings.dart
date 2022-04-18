import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/item_categories.dart';
import 'package:Zenith/screen/notification.dart';
import 'package:Zenith/screen/policy.dart';
import 'package:Zenith/screen/splash.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/widget_helper.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    List<ItemDrawer> _listItems = [
      ItemDrawer(
        0,
        "Notifications",
        Icon(
          Icons.notifications_active_outlined,
          color: Theme.of(context).backgroundColor,
          size: 15,
        ),
      ),
      ItemDrawer(
        1,
        "Privacy Policy",
        Icon(
          CustomIcons.privacy_policy,
          color: Theme.of(context).backgroundColor,
          size: 15,
        ),
      ),
      ItemDrawer(
        2,
        "Legal and About",
        Icon(
          Icons.error_outline,
          color: Theme.of(context).backgroundColor,
          size: 15,
        ),
      ),
      ItemDrawer(
        3,
        "Switch Accounts",
        Icon(
          CustomIcons.user,
          color: Theme.of(context).backgroundColor,
          size: 15,
        ),
      ),
    ];
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).backgroundColor,
        child: Scaffold(
          appBar: BaseAppBar(title: "Settings", isLeading: true),
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).backgroundColor,
            child: _listSetting(_listItems),
          ),
        ));
  }

  Widget _listSetting(List<ItemDrawer> list) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return MaterialButton(
            onPressed: () {
              setState(() {
                switch (index) {
                  case 0:
                    changeScreen(context, NotificationScreen(isBack: true));
                    break;
                  case 1:
                    changeScreen(
                        context,
                        PolicyScreen(
                            requestFor: PolicyRequestFor.PrivacyPolicy));

                    break;
                  case 2:
                    changeScreen(context,
                        PolicyScreen(requestFor: PolicyRequestFor.TermsAndUse));
                    break;
                  case 3:
                    changeToNewScreen(context, InitialScreen(), "/initial");
                    break;
                }
              });
            },
            padding: EdgeInsets.zero,
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [amber_700!, amber_400!]),
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: list[index].icon,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(list[index].name,
                          style: styleProvider(
                              fontWeight: medium,
                              size: 12,
                              color: Theme.of(context).primaryColorLight)),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
