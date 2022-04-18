import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/model/course.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:Zenith/widget/item_course.dart';
import 'package:flutter/material.dart';

import 'oops.dart';

class CourseChoreography extends StatefulWidget {
  final int courseId;
  final String title;
  const CourseChoreography(
      {Key? key, required this.courseId, required this.title})
      : super(key: key);

  @override
  _CourseChoreographyState createState() => _CourseChoreographyState();
}

class _CourseChoreographyState extends State<CourseChoreography> {
  late UserType _userType;
  @override
  void initState() {
    _userType = UserType.Student;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(
      builder: (context, model, child) {
        return Scaffold(
            appBar: BaseAppBar(
              isLeading: true,
              title: "Choreography",
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                child: _listPageProvider(model)));
      },
      authRequired: true,
      onModelReady: (model, userId, userType) async {
        _userType = await userType ?? UserType.Student;
        model.getCourseChoreographyData(courseId: widget.courseId);
      },
    );
  }

  Widget _listPageProvider(CourseViewModel provider) {
    if (provider.courseChoreographyModel.success != null &&
        provider.courseChoreographyModel.success) {
      return _listCourseClassProvider(provider.userId,
          courseData: provider.courseChoreographyModel.courseData!);
    } else if (provider.courseChoreographyModel.requestStatus ==
        RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.CourseScreen);
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.courseChoreographyModel.requestStatus));
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
                    isCourse: false,
                  )),
            ),
        itemCount: listCourseDetails.length,
        options: animOption);
  }
}
