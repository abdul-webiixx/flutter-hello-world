import 'dart:async';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/instructor_profile.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_instructor_profile.dart';
import 'package:Zenith/widget/item_instructor_review.dart';
import 'oops.dart';

class InstructorProfileScreen extends StatefulWidget {
  final Instructor model;
  const InstructorProfileScreen({Key? key, required this.model})
      : super(key: key);

  @override
  _InstructorProfileScreenState createState() =>
      _InstructorProfileScreenState();
}

class _InstructorProfileScreenState extends State<InstructorProfileScreen> {
  double rating = 0.0;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    AppViewModel.initializer();
    _firebaseService = new FirebaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(onModelReady: (model, userId, userType) {
      model
          .getInstructorProfile(instructorId: widget.model.id!)
          .then((value) => null)
          .onError((error, stackTrace) {
        _firebaseService.firebaseJsonError(
            apiCall: "fetchInstructorProfile",
            message: error.toString(),
            stackTrace: stackTrace,
            userId: "$userId");
      });
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: black,
        appBar: BaseAppBar(
          title: "Instructor Profile",
          isLeading: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  ItemInstructorProfile(model: widget.model),
                  SizedBox(
                    height: 20,
                  ),
                  _listReviewProvider(model)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () {
            reviewDialog(model);
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  width: MediaQuery.of(context).size.width - 100,
                  child: Text(
                    "Type a review",
                    style: new TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Theme.of(context).primaryColorLight),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [amber_800!, amber]),
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Theme.of(context).highlightColor,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _listReviewProvider(AppViewModel provider) {
    if (provider.instructorProfileModel.success != null &&
        provider.instructorProfileModel.success &&
        provider.instructorProfileModel.requestStatus == RequestStatus.loaded) {
      return _listReviewBuilder(model: provider.instructorProfileModel.reviews);
    } else if (provider.instructorProfileModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.instructorProfileModel.requestStatus),
        message: provider.instructorProfileModel.requestStatus ==
                RequestStatus.failure
            ? provider.failure.message
            : null,
      );
    }
  }

  Widget _listReviewBuilder({required Reviews? model}) {
    if (model != null && model.data != null && model.data!.length > 0) {
      return _listReview(list: model.data!);
    } else {
      return DataNotFound(
        isButton: false,
        userType: UserType.Trainer,
        noIcon: true,
        title: "No Review Available",
        subTitle: "Be the first to post review",
      );
    }
  }

  Widget _listReview({required List<ReviewData> list}) {
    return Container(
      height: SizeConfig.screenHeight! - 320,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: highlightColor),
      child: LiveList.options(
          scrollDirection: Axis.vertical,
          itemBuilder: (
            BuildContext context,
            int index,
            Animation<double> animation,
          ) =>
              FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                // And slide transition
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, -0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  // Paste you Widget
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: GestureDetector(
                        onTap: () {},
                        child: ItemInstructorReview(
                          model: list[index],
                        )),
                  ),
                ),
              ),
          itemCount: list.length,
          options: animOption),
    );
  }

  void reviewDialog(AppViewModel model) {
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
                height: 350,
                decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Write your review here..."),
                        GestureDetector(
                          onTap: () {
                            backToScreen(context);
                          },
                          child: Icon(Icons.close),
                        ),
                      ],
                    ),
                    Container(
                      height: 120,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: grey!, width: 0.5)),
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).highlightColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Type a review..."),
                        keyboardType: TextInputType.text,
                        controller: model.reviewController,
                        style: styleProvider(),
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      glow: true,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (model.formValidator(rating)) {
                          getUserId().then((value) {
                            if (value != null) {
                              model
                                  .getAddInstructorReview(
                                      userId: value,
                                      rating: rating,
                                      instructorId: widget.model.id!,
                                      review: model.reviewController.text)
                                  .then((value) {
                                showToast(context, msg: value.message!);
                              }).onError((error, stackTrace) {});
                            }
                          });
                          new Timer(new Duration(seconds: 2), () {
                            backToScreen(context);
                          });
                        } else {
                          showToast(context, msg: model.autoValidationError!);
                        }
                      },
                      title: "Submit",
                      padding: EdgeInsets.symmetric(vertical: 2),
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
}
