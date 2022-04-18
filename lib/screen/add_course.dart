import 'dart:async';
import 'dart:io';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/choreography.dart';
import 'package:Zenith/model/course.dart';
import 'package:Zenith/model/instructor_courses.dart';
import 'package:Zenith/model/instructor_lesson.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/local_storage.dart';
import 'package:Zenith/utils/video_player_preview.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:Zenith/widget/item_choreography_dropdown_menu.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:video_player/video_player.dart';

class AddNewCourses extends StatefulWidget {
  final Datum? model;
  final InstructorLessonDetails? instructorLessonDetails;
  const AddNewCourses({Key? key, this.model, this.instructorLessonDetails})
      : super(key: key);

  @override
  _AddNewCoursesState createState() => _AddNewCoursesState();
}

class _AddNewCoursesState extends State<AddNewCourses> {
  String? imagePath;
  XFile? pickedFile;
  VideoPlayerController? _videoPlayerController;
  final ImagePicker _imagePicker = new ImagePicker();
  late TextEditingController _videoController;
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyTitle = GlobalKey();
  GlobalKey keyLesson = GlobalKey();
  GlobalKey keyVideo = GlobalKey();
  GlobalKey keyPreview = GlobalKey();
  GlobalKey keyChoreography = GlobalKey();
  ChoreographyData? selectedItem;
  bool isPreview = false;

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(context,
        textSkip: "Got It",
        alignSkip: Alignment.bottomRight,
        targets: targets, // List<TargetFocus>
        colorShadow: Colors.red,
        paddingFocus: 10,
        opacityShadow: 0.8,
        textStyleSkip: styleProvider(), onClickOverlay: (target) {
      tutorialCoachMark!.next();
    },
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
    BasePrefs.saveData(addLessonCache, true);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(onModelReady: (model, userId, userType) {
      _videoController = new TextEditingController();
      _videoController.text = "Upload Your Video";
      getAddLessonCache().then((value) {
        if (value == null) {
          Timer(Duration(seconds: 1), () => showTutorial());
        }
      });
      if (widget.instructorLessonDetails != null) {
        model.titleController.text =
            widget.instructorLessonDetails!.title ?? "";
        model.lessonController.text =
            widget.instructorLessonDetails!.description ?? "";
        _videoController.text = widget.instructorLessonDetails!.videoId ?? "";
        isPreview = widget.instructorLessonDetails!.previewLesson != null &&
                widget.instructorLessonDetails!.previewLesson == 1
            ? true
            : false;
      }
      model.getInstructorChoreography(
          courseId: widget.model != null
              ? widget.model!.id!
              : widget.instructorLessonDetails!.courseId!);
    }, builder: (context, model, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          title: widget.model != null
              ? widget.model!.title!
              : widget.instructorLessonDetails!.title,
          isLeading: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Lesson Name",
                      key: keyTitle,
                      style: styleProvider(size: 14, fontWeight: regular),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: ""),
                        controller: model.titleController,
                        keyboardType: TextInputType.text,
                        style: styleProvider(
                            fontWeight: FontWeight.w300,
                            size: 14,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Description",
                      key: keyLesson,
                      style: styleProvider(size: 14, fontWeight: regular),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: ""),
                        controller: model.lessonController,
                        keyboardType: TextInputType.text,
                        style: styleProvider(
                            fontWeight: FontWeight.w300,
                            size: 14,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Upload Video",
                      key: keyVideo,
                      style: styleProvider(size: 14, fontWeight: regular),
                    ),
                    Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.only(left: 10, right: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        border: Border.all(color: white, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 220,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 0),
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  hintText: ""),
                              controller: _videoController,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              style: styleProvider(
                                  fontWeight: FontWeight.w300,
                                  size: 14,
                                  color: Theme.of(context).primaryColorLight),
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Visibility(
                                  visible: pickedFile != null,
                                  child: GestureDetector(
                                      onTap: () {
                                        _videoPlayerController =
                                            VideoPlayerController.file(
                                                new File(pickedFile!.path))
                                              ..initialize().then((value) =>
                                                  _videoPlayerController!
                                                      .play());
                                        videoPlayerDialog(
                                            context, _videoPlayerController!);
                                      },
                                      child: Icon(
                                        Icons.play_arrow_sharp,
                                        size: 25,
                                      )),
                                ),
                                Visibility(
                                  visible: pickedFile != null,
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _videoController.text =
                                              "Upload your video";
                                          pickedFile = null;
                                        });
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 25,
                                      )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _pickVideoFromGallery(
                                        ImageSource.gallery, model);
                                  },
                                  child: Container(
                                    width: 100,
                                    margin: EdgeInsets.only(
                                        top: 5, bottom: 5, left: 5),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.amber[500]!,
                                        Colors.amber[300]!
                                      ]),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      widget.instructorLessonDetails != null
                                          ? "Change"
                                          : "Upload",
                                      style: styleProvider(
                                          color: black,
                                          fontWeight: medium,
                                          size: 14),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _choreography(model.instructorChoreographyModel),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Preview",
                            style: styleProvider(
                                color: white, fontWeight: medium, size: 14),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          animatedToggleButton(context,
                              key: keyPreview,
                              onClick: toggleButton,
                              status: isPreview)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            model.state == ViewState.Busy
                ? new Align(
                    alignment: Alignment.center,
                    child: LoadingView(
                      msg:
                          widget.model != null ? "Uploading..." : "Updating...",
                    ),
                  )
                : Container(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 50,
          margin: EdgeInsets.only(bottom: 10),
          child: CustomButton(
            onPressed: model.state == ViewState.Busy
                ? null
                : () {
                    if (model.formValidator(
                        choreographyData: selectedItem,
                        file: pickedFile,
                        addNew: widget.model != null)) {
                      model.state = ViewState.Busy;
                      model.keyBoardDismiss(context);
                      if (widget.model != null) {
                        model
                            .getInstructorAddLesson(
                                courseId: widget.model!.id!,
                                choreographyId: selectedItem!.id!,
                                title: model.titleController.text,
                                previewLesson: isPreview ? 1 : 0,
                                status: selectedItem!.status,
                                description: model.lessonController.text,
                                videoPath: pickedFile!.path,
                                videoName: pickedFile!.name)
                            .then((value) {
                          model.state = ViewState.Idle;
                          showToast(context, msg: value.message!);
                          backToScreen(context);
                        }).onError((error, stackTrace) {
                          model.state = ViewState.Idle;
                          showToast(context, msg: error.toString());
                        });
                      } else {
                        model
                            .getInstructorUpdateLesson(
                                lessonId: widget.instructorLessonDetails!.id!,
                                title: model.titleController.text,
                                previewLesson: isPreview ? 1 : 0,
                                status:
                                    widget.instructorLessonDetails!.status ??
                                        "Pending",
                                description: model.lessonController.text,
                                videoPath:
                                    widget.instructorLessonDetails != null &&
                                            pickedFile != null
                                        ? pickedFile!.path
                                        : null,
                                videoName:
                                    widget.instructorLessonDetails != null &&
                                            pickedFile != null
                                        ? pickedFile!.name
                                        : null)
                            .then((value) {
                          model.state = ViewState.Idle;
                          showToast(context, msg: value.message!);
                          backToScreen(context);
                        }).onError((error, stackTrace) {
                          model.state = ViewState.Idle;
                          showToast(context, msg: error.toString());
                        });
                      }
                    } else {
                      showToast(context, msg: model.autoValidationError!);
                    }
                  },
            title: widget.instructorLessonDetails != null ? "Update" : "Submit",
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.dispose();
    }
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
                      "As mark as preview video\nwill be visible to all user",
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
        identify: "keyChoreography",
        keyTarget: keyChoreography,
        color: Theme.of(context).highlightColor,
        alignSkip: Alignment.center,
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
                      "Choreography",
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
                      "Select your choreography in\n which you want to save",
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

  void _pickVideoFromGallery(ImageSource source, CourseViewModel model) async {
    pickedFile = await _imagePicker.pickVideo(
      source: source,
    );
    setState(() {
      _videoController.text = pickedFile!.name;
    });
  }

  void toggleButton() {
    setState(() {
      isPreview = !isPreview;
    });
  }

  void onDropdownButtonClick(ChoreographyData model) {
    setState(() {
      selectedItem = model;
    });
  }

  Widget _choreography(InstructorChoreographyModel model) {
    if (model.requestStatus == RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.Choreography);
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0), color: highlightColor),
        child: ChoreographyListDropdown(
          key: keyChoreography,
          defaultValue: selectedItem,
          list: model.choreographyData != null ? model.choreographyData : [],
          hint: getChoreographyData(model.choreographyData),
          onChanged: onDropdownButtonClick,
          disable: widget.instructorLessonDetails != null,
        ),
      );
    }
  }

  String getChoreographyData(List<ChoreographyData>? model) {
    String title = "Select Choreography";
    if (widget.instructorLessonDetails != null &&
        widget.instructorLessonDetails!.choreographyId != null &&
        model != null) {
      for (int i = 0; i < model.length; i++) {
        if (model[i].id == widget.instructorLessonDetails!.choreographyId!) {
          title = model[i].name!;
        }
      }
    }
    return title;
  }
}
