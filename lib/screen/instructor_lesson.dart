import 'dart:async';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/instructor_lesson.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/local_storage.dart';
import 'package:Zenith/utils/video_player_preview.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:Zenith/widget/item_instructor_lesson.dart';

import 'package:flutter/material.dart';
import 'oops.dart';

class InstructorLessonScreen extends StatefulWidget {
  final int choreographyId;
  InstructorLessonScreen({Key? key, required this.choreographyId})
      : super(key: key);

  @override
  _InstructorLessonScreenState createState() => _InstructorLessonScreenState();
}

class _InstructorLessonScreenState extends State<InstructorLessonScreen>
    with SingleTickerProviderStateMixin {
  bool isSort = false;
  late AnimationController controller;
  late Animation<Offset> offset;
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keySort = GlobalKey();
  GlobalKey keyTrailing = GlobalKey();
  GlobalKey keyEdit = GlobalKey();
  GlobalKey keyPreview = GlobalKey();
  GlobalKey keyDelete = GlobalKey();

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(context,
        textSkip: "Got It",
        alignSkip: Alignment.bottomLeft,
        targets: targets, // List<TargetFocus>
        colorShadow: Colors.red,
        paddingFocus: 10,
        opacityShadow: 0.8,
        textStyleSkip: styleProvider(),
        // DEFAULT Colors.black
        onFinish: () {
      cachedMarkFinished();
    }, onClickTarget: (target) {
      print(target);
    }, onSkip: () {
      cachedMarkFinished();
    })
      ..show();
  }

  void cachedMarkFinished() {
    BasePrefs.saveData(lessonCache, true);
  }

  @override
  void dispose() {
    targets.clear();
    if (tutorialCoachMark != null) {
      tutorialCoachMark!.finish();
    }
    super.dispose();
  }

  void initTargets() {
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "keySort",
        keyTarget: keySort,
        color: Theme.of(context).highlightColor,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Rearrange Lesson List",
                      style: styleProvider(
                        size: 18,
                        fontWeight: bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Divider(
                          height: 1,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "To arrange lesson list please\nclick on sort button",
                      style: styleProvider(
                        size: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: medium,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyTrailing",
        keyTarget: keyTrailing,
        color: Theme.of(context).highlightColor,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Rearrange Lesson List",
                      style: styleProvider(
                        size: 18,
                        fontWeight: bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Image.asset(
                      ic_sort_arrow,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    Text(
                      "drag and drop the lesson\nfor rearrange",
                      style: styleProvider(
                        size: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: medium,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyEdit",
        keyTarget: keyEdit,
        color: Theme.of(context).highlightColor,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Update Lesson",
                      style: styleProvider(
                        size: 18,
                        fontWeight: bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Divider(
                          height: 1,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "click to update you lesson",
                      style: styleProvider(
                        size: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: medium,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyPreview",
        keyTarget: keyPreview,
        color: Theme.of(context).highlightColor,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.right,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Preview Video",
                      style: styleProvider(
                        size: 18,
                        fontWeight: bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Divider(
                          height: 1,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "click to play and preview\nyour lesson video",
                      style: styleProvider(
                        size: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: medium,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "keyDelete",
        keyTarget: keyDelete,
        color: Theme.of(context).highlightColor,
        alignSkip: Alignment.bottomRight,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Delete Lesson",
                      style: styleProvider(
                        size: 18,
                        fontWeight: bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Divider(
                          height: 1,
                          color: Theme.of(context).primaryColorLight),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "double tap & long press\nto delete your lesson",
                      style: styleProvider(
                        size: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: medium,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1.0))
        .animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(onModelReady: (model, userId, userType) {
      model
          .getInstructorLesson(choreographyId: widget.choreographyId)
          .then((value) {
        if (value.instructorLessonDetails != null &&
            value.instructorLessonDetails!.length > 1) {
          getLessonCache().then((value) {
            if (value == null) {
              Timer(Duration(seconds: 1), () => showTutorial());
            }
          });
        }
      });
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
          title: "Lesson",
          isSuffixIcon: false,
          suffixIcon: Visibility(
            visible: model.instructorLessonModel.instructorLessonDetails !=
                    null &&
                model.instructorLessonModel.instructorLessonDetails!.length > 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sort",
                  style: styleProvider(),
                ),
                SizedBox(
                  width: 10,
                ),
                animatedToggleButton(context,
                    key: keySort, onClick: toggleButton, status: isSort),
              ],
            ),
          ),
        ),
        body: Container(
            height: SizeConfig.screenHeight, child: _listPageProvider(model)),
      );
    });
  }

  void toggleButton() {
    setState(() {
      isSort = !isSort;
    });
  }

  Widget _listPageProvider(CourseViewModel provider) {
    if (provider.instructorLessonModel.success != null &&
        provider.instructorLessonModel.success) {
      return _listCourseClasses(
          list: provider.instructorLessonModel.instructorLessonDetails);
    } else if (provider.instructorLessonModel.requestStatus ==
        RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.CourseScreen);
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.instructorLessonModel.requestStatus));
    }
  }

  Widget _listCourseClasses({required List<InstructorLessonDetails>? list}) {
    if (list != null && list.length > 0) {
      return ReorderList(
        previewKey: keyPreview,
        editKey: keyEdit,
        deleteKey: keyDelete,
        trailingKey: keyTrailing,
        list: list,
        isSort: isSort,
      );
    } else {
      return DataNotFound(
        subTitle: "",
        userType: UserType.Trainer,
        title: "No Lesson Added",
      );
    }
  }
}

class ReorderList extends StatefulWidget {
  final List<InstructorLessonDetails> list;
  final bool isSort;
  final Key? trailingKey;
  final Key? previewKey;
  final Key? editKey;
  final Key? deleteKey;
  final GestureTapCallback? onDeleteTap;
  const ReorderList(
      {Key? key,
      required this.trailingKey,
      required this.previewKey,
      this.editKey,
      this.deleteKey,
      this.onDeleteTap,
      required this.list,
      required this.isSort})
      : super(key: key);

  @override
  _ReorderListState createState() => _ReorderListState();
}

class _ReorderListState extends State<ReorderList> {
  late CourseViewModel _courseViewModel;

  @override
  void initState() {
    super.initState();
    _courseViewModel = Provider.of<CourseViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ReorderableListView(
            buildDefaultDragHandles: widget.isSort,
            children: List.generate(
              widget.list.length,
              (index) {
                return ItemInstructorLesson(
                  trailingKey: index == 1 ? widget.trailingKey : null,
                  editKey: index == 1 ? widget.editKey : null,
                  previewKey: index == 1 ? widget.previewKey : null,
                  instructorLessonDetails: widget.list[index],
                  index: widget.list[index].id!,
                  deleteKey: index == 0 ? widget.deleteKey : null,
                  key: ValueKey(widget.list[index]),
                  onDeleteTap: () {
                    deleteItemDialog(index);
                  },
                );
              },
            ),
            onReorder: reorderData));
  }

  void deleteItemDialog(int index) {
    showGeneralDialog(
        barrierLabel: "delete lesson",
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
                          Icon(Icons.delete_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Delete Lesson", style: styleProvider()),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      height: 2,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    SizedBox(height: 15),
                    Text("Are you sure you would like to delete this lesson?",
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
                              _courseViewModel
                                  .getInstructorDeleteLesson(
                                      lessonId: widget.list[index].id!)
                                  .then((value) {
                                showToast(context,
                                    msg: value.message!,
                                    bgColor: Theme.of(context)
                                        .errorColor
                                        .withOpacity(0.8));
                                widget.list.removeAt(index);
                                backToScreen(context);
                              });
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

  void reorderData(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final items = widget.list.removeAt(oldIndex);
      widget.list.insert(newIndex, items);
      _courseViewModel
          .getInstructorLessonSequence(
              lessonId: widget.list[newIndex].id!, sequenceId: newIndex)
          .then((value) {});
    });
  }

  void sorting() {
    setState(() {
      widget.list.sort();
    });
  }
}
