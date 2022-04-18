import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/course_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/course_lesson.dart';
import 'package:Zenith/screen/course_package.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_course_lesson.dart';
import 'livestream.dart';
import 'oops.dart';

class CourseLessonScreen extends StatefulWidget {
  final int userId;
  final int packageId;
  final int courseId;
  final String title;
  final int choreographyId;
  CourseLessonScreen(
      {Key? key,
      required this.userId,
      required this.courseId,
      required this.packageId,
      required this.title,
      required this.choreographyId})
      : super(key: key);
  @override
  _CourseLessonScreenState createState() => _CourseLessonScreenState();
}

class _CourseLessonScreenState extends State<CourseLessonScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _listPageProvider(CourseViewModel provider) {
    if (provider.courseLessonPackageModel.success != null &&
        provider.courseLessonPackageModel.success) {
      return _pageBuilder(model: provider.courseLessonPackageModel);
    } else if (provider.courseLessonPackageModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.courseLessonPackageModel.requestStatus));
    }
  }

  Widget _pageBuilder({required CourseLessonPackageModel model}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${widget.title}",
              style: styleProvider(size: 18.0, fontWeight: semiBold)),
          Text(
              "${model.courseInformation != null ? model.courseInformation!.lessons! : 0} Lessons",
              style: styleProvider(size: 12.0, color: grey)),
          SizedBox(
            height: 10,
          ),
          Container(
              height: MediaQuery.of(context).size.height - 155,
              child: _listLessonProvider(model: model.courseLessonPackageData))
        ],
      ),
    );
  }

  Widget _listLessonProvider({required CourseLessonPackageData? model}) {
    if (model != null &&
        model.courseLessonPackageDetails != null &&
        model.courseLessonPackageDetails!.length > 0) {
      return _listLesson(list: model.courseLessonPackageDetails!);
    } else {
      return DataNotFound();
    }
  }

  Widget _listLesson({required List<CourseLessonPackageDetails> list}) {
    return LiveList.options(
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
                child: MaterialButton(
                  onPressed: () {
                    if (list[index].previewLesson != 0) {
                      _moveToNext(
                          packageId: list[index].packageId ?? 0,
                          lessonId: list[index].id!,
                          choreographyId: list[index].choreographyId!,
                          courseId: list[index].courseId!);
                    } else if (list[index].subscription == null) {
                      changeScreen(
                          context,
                          CoursePackageScreen(
                              courseId: list[index].courseId!,
                              title: list[index].title!));
                    } else if (list[index].subscription == "active") {
                      _moveToNext(
                          packageId: list[index].packageId!,
                          lessonId: list[index].id!,
                          choreographyId: list[index].choreographyId!,
                          courseId: list[index].courseId!);
                    } else {
                      _moveToNext(
                          packageId: list[index].packageId!,
                          lessonId: list[index].id!,
                          choreographyId: list[index].choreographyId!,
                          courseId: list[index].courseId!);
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: ItemCourseLesson(
                    model: list[index],
                  ),
                ),
              ),
            ),
        itemCount: list.length,
        options: animOption);
  }

  void _moveToNext(
      {required int packageId,
      required int lessonId,
      required int choreographyId,
      required int courseId}) {
    changeScreen(
        context,
        LiveStreamingScreen(
          userId: widget.userId,
          packageId: packageId,
          isLive: false,
          choreographyId: choreographyId,
          lessonId: lessonId,
          courseId: courseId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: BaseAppBar(
              isLeading: true,
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                child: _listPageProvider(model)));
      },
      onModelReady: (model, userId, userType) {
        model.getCourseLessonPackageData(
            courseId: widget.courseId,
            coursePackageId: widget.packageId,
            userId: widget.userId,
            choreographyId: widget.choreographyId);
      },
    );
  }
}
