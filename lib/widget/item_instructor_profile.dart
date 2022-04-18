import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/course.dart';
import 'package:Zenith/screen/edit_profile.dart';
import 'package:Zenith/screen/instructor_course_screen.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemInstructorProfile extends StatefulWidget {
  final Instructor model;
  const ItemInstructorProfile({Key? key, required this.model})
      : super(key: key);

  @override
  _ItemInstructorProfileState createState() => _ItemInstructorProfileState();
}

class _ItemInstructorProfileState extends State<ItemInstructorProfile> {
  late FirebaseService _firebaseService;
  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(
        fullScreen: true,
        authRequired: true,
        onModelReady: (model, userId, userType) {
          model.getUserAccess();
          printLog("nkjbjkbjkbjhb", widget.model.toJson());
          model.setUserId(userId);
        },
        builder: (context, model, child) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).highlightColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: widget.model.avatar.toString() ==
                                    "https://zenithdance-images.s3.ap-south-1.amazonaws.com/users/default.png"
                                ? thumbnail_user_home
                                : widget.model.avatar!,
                            fit: BoxFit.fitWidth,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Image.asset(
                              moke_image3,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.model.name!,
                            style: styleProvider(),
                          ),
                          Text(
                            "Instructor",
                            style: styleProvider(
                                size: 12, color: grey, fontWeight: thin),
                          ),
                          Container(
                              width: SizeConfig.screenWidth! / 2 - 70,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  children: [
                                    RatingBar(
                                        itemSize: 20,
                                        initialRating: getDoubleValue(
                                            widget.model.totalRatings),
                                        minRating: 1,
                                        ignoreGestures: true,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 0),
                                        ratingWidget: RatingWidget(
                                            full: new Icon(
                                              Icons.star,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            half: new Icon(
                                              Icons.star_half,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            empty: new Icon(
                                              Icons.star_border,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                        }),
                                    Text(
                                      widget.model.totalRatings != null
                                          ? " (${widget.model.totalRatings})"
                                          : " (0.0)",
                                      style: styleProvider(color: grey),
                                    ),
                                  ],
                                ),
                              )),
                          model.userType == UserType.Trainer
                              ? MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    printLog("nkjnjnkj", model.userId ?? 0);
                                    model
                                        .getProfileData(
                                            userId: model.userId ?? 0)
                                        .then((value) {
                                      printLog("nlkjnkjnjn", value.toJson());
                                      changeScreen(
                                          context,
                                          EditProfileScreen(
                                              model: value.userInformation!));
                                    }).onError((error, stackTrace) {
                                      _firebaseService.firebaseJsonError(
                                          apiCall: "getProfileData",
                                          stackTrace: stackTrace,
                                          message: error.toString(),
                                          userId: widget.model.id!);
                                    });
                                  },
                                  child: Container(
                                      width: 150,
                                      child: Container(
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFFFB60D),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30.0,
                                              right: 30,
                                              top: 5,
                                              bottom: 5),
                                          child: Center(
                                            child: Text('EDIT ACCOUNT',
                                                style: styleProvider(
                                                    fontWeight: semiBold,
                                                    size: 10,
                                                    color: Theme.of(context)
                                                        .backgroundColor)),
                                          ),
                                        ),
                                      )),
                                )
                              : Container()
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [amber_400!, amber_600!, amber_600!]),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Classes",
                            style: styleProvider(
                              size: 12,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                          Text(
                            "${widget.model.classes} classes",
                            style: styleProvider(
                              size: 10,
                              fontWeight: thin,
                              color: Theme.of(context).backgroundColor,
                            ),
                            maxLines: 2,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                      width: MediaQuery.of(context).size.width / 2.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Courses",
                                style: styleProvider(size: 12),
                              ),
                              Text(
                                widget.model.danceForm != null
                                    ? "${widget.model.danceForm}"
                                    : "not available",
                                style: styleProvider(
                                    color: grey, size: 8, fontWeight: thin),
                                maxLines: 2,
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (model.userType == UserType.Trainer) {
                                changeScreen(
                                    context,
                                    InstructorCourseScreen(
                                      isBack: true,
                                    ));
                              }
                              printLog("bhjbhbj", model.userType);
                            },
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [amber_400!, amber_600!]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                              ),
                              width: 25,
                              height: 25,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                                color: Theme.of(context).highlightColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
