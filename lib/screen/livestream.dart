import 'dart:async';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/view_model/course_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:html/parser.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/comment_details.dart';
import 'package:Zenith/screen/join_meeting.dart';
import 'package:Zenith/screen/video.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_comment.dart';
import 'oops.dart';

class LiveStreamingScreen extends StatefulWidget {
  final int userId;
  final int packageId;
  final int? lessonId;
  final int? courseId;
  final int? choreographyId;
  final bool isLive;
  LiveStreamingScreen(
      {Key? key,
      required this.userId,
      required this.packageId,
      this.lessonId,
      this.courseId,
      this.choreographyId,
      required this.isLive})
      : super(key: key);
  @override
  _LiveStreamingScreenState createState() => _LiveStreamingScreenState();
}

class _LiveStreamingScreenState extends State<LiveStreamingScreen> {
  late TextEditingController _commentController;
  late int currentLike = 0;
  int? commentTotal;
  bool isVisible = false;
  bool isLiked = false;
  bool urlUpdate = false;

  @override
  void initState() {
    _commentController = new TextEditingController();
    checkVideoURL();
    super.initState();
  }

  checkVideoURL() {
    Timer(const Duration(seconds: 1), () {
      setState(() {
        urlUpdate = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _pageBuilder({required CourseViewModel model}) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 300),
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    urlUpdate
                        ? VideoPlayerScreen(
                            videoUrl:
                                model.courseLessonDetailsModel.videoModel !=
                                            null &&
                                        model.courseLessonDetailsModel
                                                .videoModel!.videoUrl !=
                                            null
                                    ? model.courseLessonDetailsModel.videoModel!
                                        .videoUrl!
                                    : "",
                            thumbUrl:
                                model.courseLessonDetailsModel.videoModel !=
                                            null &&
                                        model.courseLessonDetailsModel
                                                .videoModel!.videoThumb !=
                                            null
                                    ? model.courseLessonDetailsModel.videoModel!
                                        .videoThumb!
                                    : "",
                          )
                        : SizedBox(),
                    new Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        child: Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: MaterialButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                    child: Icon(
                                  CustomIcons.left_arrow,
                                  size: 12,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    height: 20,
                                    child: Text(
                                      "${model.courseLessonDetailsModel.courseInformation != null ? model.courseLessonDetailsModel.courseInformation!.title : ""}",
                                      overflow: TextOverflow.ellipsis,
                                      style: styleProvider(
                                          size: 14,
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontWeight: semiBold),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          CustomIcons.eye_on,
                                          size: 17,
                                          color: amber,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${model.courseLessonDetailsModel.otherInformation != null ? model.courseLessonDetailsModel.otherInformation!.totalViews : 0}",
                                          style: styleProvider(
                                              size: 10,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              fontWeight: regular),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              if (isLiked) {
                                                model
                                                    .getRemoveLike(
                                                        lessonId:
                                                            widget.lessonId!,
                                                        packageId:
                                                            widget.packageId,
                                                        userId: widget.userId)
                                                    .then((value) {
                                                  showToast(context,
                                                      msg: value.message!);
                                                  if (value.success) {
                                                    setState(() {
                                                      currentLike--;
                                                      isLiked = !isLiked;
                                                    });
                                                  }
                                                }).onError(
                                                        (error, stackTrace) {});
                                              } else {
                                                model
                                                    .getAddLike(
                                                        lessonId:
                                                            widget.lessonId!,
                                                        packageId:
                                                            widget.packageId,
                                                        userId: widget.userId)
                                                    .then((value) {
                                                  showToast(context,
                                                      msg: value.message!);
                                                  if (value.success) {
                                                    setState(() {
                                                      currentLike++;
                                                      isLiked = !isLiked;
                                                    });
                                                  }
                                                }).onError(
                                                        (error, stackTrace) {});
                                              }
                                            },
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    isLiked
                                                        ? Icons
                                                            .thumb_up_alt_sharp
                                                        : Icons
                                                            .thumb_up_alt_outlined,
                                                    size: 15,
                                                    color: amber,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    "${model.courseLessonDetailsModel.otherInformation != null ? "${getTotalLike(totalLike: model.courseLessonDetailsModel.otherInformation!.totalLikes!, userLike: currentLike)}" : currentLike}",
                                                    style: styleProvider(
                                                        size: 12,
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                        fontWeight: regular),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: Text(
                                "${model.courseLessonDetailsModel.courseInformation!.description != null ? "${parse(model.courseLessonDetailsModel.courseInformation!.description).documentElement!.text}" : ""}",
                                textAlign: TextAlign.justify,
                                style: styleProvider(
                                    size: 12,
                                    color: Theme.of(context).hintColor,
                                    fontWeight: regular),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    "Comments",
                                    style: styleProvider(
                                        size: 12,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: regular),
                                  ),
                                  Text(
                                    " (${commentTotal != null ? commentTotal : 0})",
                                    style: styleProvider(
                                        size: 10,
                                        color: Theme.of(context).hintColor,
                                        fontWeight: regular),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Icon(isVisible
                                    ? Icons.keyboard_arrow_down_outlined
                                    : Icons.keyboard_arrow_up_outlined),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
          color: black,
          child: Visibility(visible: !isVisible, child: _listProvider(model))),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        height: 40,
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
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).highlightColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).highlightColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Type a comment..."),
                keyboardType: TextInputType.text,
                controller: _commentController,
                style: new TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Theme.of(context).primaryColorLight),
              ),
            ),
            GestureDetector(
              onTap: () {
                model
                    .getAddComment(
                        lessonId: widget.lessonId!,
                        packageId: widget.packageId,
                        userId: widget.userId,
                        comments: _commentController.text)
                    .then((value) {
                      if (value.success) {
                        _commentController.clear();
                        showToast(context, msg: value.message!);
                        model
                            .getComment(
                                lessonId: widget.lessonId!,
                                packageId: widget.packageId)
                            .then((value) {
                          if (value.commentData != null &&
                              value.commentData!.commentDetails != null) {
                            setState(() {
                              commentTotal = value.commentData!.total;
                            });
                          }
                        }).onError((error, stackTrace) => null);
                      }
                    })
                    .onError((error, stackTrace) => null)
                    .then((value) {});
              },
              child: Container(
                margin: EdgeInsets.only(right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [amber_800!, amber]),
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                ),
                width: 30,
                height: 30,
                child: Icon(
                  Icons.chat_bubble_outline,
                  size: 15,
                  color: Theme.of(context).highlightColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _listProvider(CourseViewModel provider) {
    if (provider.commentModel.success != null &&
        provider.commentModel.success &&
        provider.commentModel.commentData != null &&
        provider.commentModel.commentData!.commentDetails != null &&
        provider.commentModel.commentData!.commentDetails!.length > 0) {
      return _listComments(
          list: provider.commentModel.commentData!.commentDetails!);
    } else {
      return Container();
    }
  }

  Widget _listComments({required List<Comment> list}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
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
                    child: ItemComments(model: list[index]),
                  ),
                ),
            itemCount: list.length,
            options: animOption));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: widget.isLive ? livePageUi() : playerPageUi(),
      ),
    );
  }

  Widget livePageUi() {
    return BaseView<ClassViewModel>(
        fullScreen: true,
        onModelReady: (model, userId, userType) {
          model.getJoinClass(
              userId: widget.userId, packageId: widget.packageId);
        },
        builder: (context, model, child) {
          if (model.joinClassModel.success != null &&
              model.joinClassModel.success &&
              model.joinClassModel.joinClassData != null) {
            return MeetingWidget(
              meetingId: model.joinClassModel.joinClassData!.meetingId!,
              meetingPassword: model.joinClassModel.joinClassData!.password!,
            );
          } else if (model.joinClassModel.requestStatus ==
              RequestStatus.loading) {
            return LoadingProgress();
          } else {
            return SomethingWentWrong(
                status: getResponse(model.joinClassModel.requestStatus));
          }
        });
  }

  Widget playerPageUi() {
    return BaseView<CourseViewModel>(
        fullScreen: true,
        onModelReady: (model, userId, userType) {
          model
              .getCourseLessonPackageDetails(
                  lessonId: widget.lessonId!,
                  courseId: widget.courseId!,
                  packageId: widget.packageId,
                  userId: widget.userId,
                  choreographyId: widget.choreographyId!)
              .then((value) {
            if (value.courseInformation != null &&
                value.courseInformation!.isLiked != null) {
              isLiked = value.courseInformation!.isLiked!;
            }
          }).onError((error, stackTrace) => null);
          model
              .getComment(
                  lessonId: widget.lessonId!, packageId: widget.packageId)
              .then((value) {
            if (value.commentData != null &&
                value.commentData!.commentDetails != null) {
              commentTotal = value.commentData!.total;
            }
          }).onError((error, stackTrace) => null);
        },
        builder: (context, model, child) {
          if (model.courseLessonDetailsModel.success != null &&
              model.courseLessonDetailsModel.success) {
            return _pageBuilder(model: model);
          } else if (model.courseLessonDetailsModel.requestStatus ==
              RequestStatus.loading) {
            return LoadingProgress();
          } else {
            return SomethingWentWrong(
                status:
                    getResponse(model.courseLessonDetailsModel.requestStatus));
          }
        });
  }

  int getTotalLike({required int totalLike, required int userLike}) {
    return totalLike + userLike;
  }
}
