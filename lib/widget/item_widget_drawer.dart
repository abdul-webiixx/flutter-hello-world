import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/screen/join_screen.dart';
import 'package:Zenith/utils/video_player_preview.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/item.dart';
import 'package:Zenith/model/profile.dart';
import 'package:Zenith/screen/cart.dart';
import 'package:Zenith/screen/contactus.dart';
import 'package:Zenith/screen/coupon_details.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/screen/notification.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/order_history.dart';
import 'package:Zenith/screen/review.dart';
import 'package:Zenith/screen/settings.dart';
import 'package:Zenith/screen/subscribe.dart';
import 'package:Zenith/screen/policy.dart';
import 'package:Zenith/screen/support.dart';
import 'package:Zenith/screen/user_profile.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class DrawerBuilder extends StatefulWidget {
  final int userId;
  DrawerBuilder({Key? key, required this.userId}) : super(key: key);
  @override
  _DrawerBuilderState createState() => _DrawerBuilderState();
}

class _DrawerBuilderState extends State<DrawerBuilder> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(
        fullScreen: true,
        authRequired: true,
        onModelReady: (model, userId, userType) async {
          if (userId != null) {
            model.getProfileData(userId: userId);
          }
        },
        builder: (context, model, child) {
          return Scaffold(
            body: pageProvider(model),
          );
        });
  }

  Widget pageProvider(UserViewModel provider) {
    if (provider.profileModel.success != null &&
        provider.profileModel.success) {
      return pageBuilder(model: provider.profileModel);
    } else if (provider.profileModel.requestStatus == RequestStatus.loading) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LoadingView(),
      );
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.profileModel.requestStatus));
    }
  }

  Widget pageBuilder({required ProfileModel model}) {
    List<WidgetItem> itemList = [
      WidgetItem(0, "Home", CustomIcons.home__4_),
      WidgetItem(1, "Notification", CustomIcons.notification),
      WidgetItem(2, "My Orders", CustomIcons.delivery_box),
      WidgetItem(3, "Coupons", CustomIcons.coupons),
      WidgetItem(4, "Account Settings", CustomIcons.settings),
      WidgetItem(5, "Reviews", CustomIcons.reviews),
      WidgetItem(6, "Supports", CustomIcons.support),
      WidgetItem(7, "Active Subscriptions", CustomIcons.courses),
      WidgetItem(8, "My Carts", Icons.shopping_cart_outlined),
      WidgetItem(8, "Start Meeting", Icons.highlight),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: Container(
          child: SafeArea(
            child: MaterialButton(
              onPressed: () {
                changeScreen(
                    context,
                    UserProfileScreen(
                      userId: widget.userId,
                    ));
              },
              padding: EdgeInsets.zero,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 90,
                alignment: Alignment.center,
                width: SizeConfig.screenWidth,
                color: highlightColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50.0,
                          height: 50.0,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              color: highlightColor,
                              borderRadius: BorderRadius.circular(100)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: CachedNetworkImage(
                              imageUrl: model.userInformation != null &&
                                      model.userInformation!.avatar != null &&
                                      model.userInformation.toString() ==
                                          "https://zenithdance-images.s3.ap-south-1.amazonaws.com/users/default.png"
                                  ? model.userInformation!.avatar!
                                  : thumbnail_user,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) =>
                                  Image.network(
                                thumbnail_user,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Hi ${model.userInformation!.name!.toUpperCase()}",
                                  style: styleProvider(
                                      fontWeight: semiBold,
                                      size: 14,
                                      color:
                                          Theme.of(context).primaryColorLight)),
                              Text("${model.userInformation!.email!}",
                                  style: styleProvider(
                                      fontWeight: regular,
                                      size: 10,
                                      color: Theme.of(context).hintColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      iconSize: 20,
                      color: white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return MaterialButton(
                      onPressed: () {
                        setState(() {
                          switch (index) {
                            case 0:
                              changeScreen(context, MainScreen(currentTab: 0));
                              break;
                            case 1:
                              changeScreen(
                                  context,
                                  NotificationScreen(
                                    isBack: true,
                                  ));
                              break;
                            case 2:
                              changeScreen(
                                  context, OrderHistory(userId: widget.userId));
                              break;
                            case 3:
                              changeScreen(context,
                                  CouponDetailsScreen(userId: widget.userId));
                              break;
                            case 4:
                              changeScreen(context, AccountSettingScreen());
                              break;
                            case 5:
                              changeScreen(context, ReviewScreen());
                              break;
                            case 6:
                              changeScreen(
                                  context,
                                  SupportScreen(
                                    userName: model.userInformation != null &&
                                            model.userInformation!.name != null
                                        ? model.userInformation!.name!
                                        : dummyUser,
                                    userEmail: model.userInformation != null &&
                                            model.userInformation!.email != null
                                        ? model.userInformation!.email!
                                        : dummyMail,
                                  ));
                              break;
                            case 7:
                              changeScreen(context,
                                  SubscribeScreen(userId: widget.userId));
                              break;
                            case 8:
                              changeScreen(context, CartScreen());
                              break;
                            case 9:
                              changeScreen(context, JoinWidget());
                              break;
                          }
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              child: Icon(
                                itemList[index].icon,
                                size: itemList[index].icon ==
                                            CustomIcons.coupons ||
                                        itemList[index].icon ==
                                            CustomIcons.courses ||
                                        itemList[index].icon ==
                                            CustomIcons.reviews
                                    ? 12
                                    : 17,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              itemList[index].name,
                              style:
                                  styleProvider(size: 16, fontWeight: regular),
                            )
                          ],
                        ),
                      ));
                }),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 190,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 0.5,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    onPressed: () {
                      changeScreen(
                          context,
                          ContactUsScreen(
                            model: model.userInformation,
                          ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              child: Icon(
                                CustomIcons.contact_us,
                                size: 15,
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Contact Us",
                                style: styleProvider(
                                    fontWeight: regular,
                                    size: 16,
                                    color:
                                        Theme.of(context).primaryColorLight)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      changeScreen(
                          context,
                          PolicyScreen(
                              requestFor: PolicyRequestFor.TermsAndUse));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                child: SvgPicture.asset(
                                  ic_trms,
                                  height: 20,
                                  width: 11,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text("Terms & Conditions",
                                  style: styleProvider(
                                      fontWeight: regular,
                                      size: 16,
                                      color:
                                          Theme.of(context).primaryColorLight)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                signOutDialog(context);
              },
              padding: EdgeInsets.zero,
              child: Container(
                color: Theme.of(context).highlightColor,
                margin: EdgeInsets.only(top: 7),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CustomIcons.logout,
                          size: 20,
                          color: Theme.of(context).primaryColorLight,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Sign out",
                            style: styleProvider(
                                fontWeight: regular,
                                size: 16,
                                color: Theme.of(context).primaryColorLight)),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
