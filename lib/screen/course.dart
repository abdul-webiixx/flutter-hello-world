import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/course.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_course.dart';

class CourseScreen extends StatefulWidget {
  final double? height;
  final bool? isBack;
  CourseScreen({Key? key, this.height, this.isBack}) : super(key: key);
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late int? courseCount;
  late int? lessonCount;
  late UserType _userType;

  @override
  void initState() {
    lessonCount = 0;
    courseCount = 0;
    _userType = UserType.Student;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(
      authRequired: true,
      onModelReady: (model, userId, userType) async {
        lessonCount = 0;
        courseCount = 0;
        _userType = await userType ?? UserType.Student;
        model.courseModel.requestStatus = RequestStatus.loading;
        model.getCourseData(userId: userId!);
      },
      builder: (context, model, child) {
        return SafeArea(
          child: Scaffold(
            appBar: widget.isBack != null
                ? BaseAppBar(
                    isLeading: widget.isBack,
                    title: "",
                  )
                : null,
            body: Container(
              color: Theme.of(context).backgroundColor,
              height: widget.height != null
                  ? widget.height
                  : MediaQuery.of(context).size.height - 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dance Courses",
                      style: styleProvider(size: 18.0, fontWeight: semiBold)),
                  Text("$courseCount Courses",
                      style: styleProvider(
                          size: 12.0, color: grey, fontWeight: thin)),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: _listCourseProvider(model),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _listCourseProvider(CourseViewModel provider) {
    if (provider.courseModel.success != null && provider.courseModel.success) {
      print(provider.userId);
      return _listCourseClassProvider(provider.userId,
          courseData: provider.courseModel.courseData!);
    } else if (provider.courseModel.requestStatus == RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.CourseScreen);
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.courseModel.requestStatus));
    }
  }

  Widget _listCourseClassProvider(int userId,
      {required CourseData courseData}) {
    if (courseData.courseDetails != null &&
        courseData.courseDetails!.length > 0) {
      return _listCourseClasses(userId,
          listCourseDetails: courseData.courseDetails!);
    } else {
      return DataNotFound();
    }
  }

  Widget _listCourseClasses(int userId,
      {required List<CourseDetails> listCourseDetails}) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        if (listCourseDetails.length > 0) {
          lessonCount = 0;
          courseCount = listCourseDetails.length;
          for (int i = 0; i < listCourseDetails.length; i++) {
            lessonCount = lessonCount! + listCourseDetails[i].lessons!;
          }
        }
      });
    });
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
                  child: ItemCourse(
                    userId: userId,
                    userType: _userType,
                    model: listCourseDetails[index],
                    isCourse: true,
                  )),
            ),
        itemCount: listCourseDetails.length,
        options: animOption);
  }
}
