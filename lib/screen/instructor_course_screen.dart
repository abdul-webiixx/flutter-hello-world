import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/model/instructor_courses.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:Zenith/widget/Item_instructor_course.dart';
import 'package:Zenith/widget/item_course.dart';
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

class InstructorCourseScreen extends StatefulWidget {
  final double? height;
  final bool? isBack;
  InstructorCourseScreen({Key? key, this.height, this.isBack}) : super(key: key);
  @override
  _InstructorCourseScreenState createState() => _InstructorCourseScreenState();
}

class _InstructorCourseScreenState extends State<InstructorCourseScreen> {
  late int? courseCount;
  late int? lessonCount;
  late UserType _userType;

  @override
  void initState() {
    lessonCount = 0;
    courseCount = 0;
    _userType = UserType.Trainer;
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(
      authRequired: true,
      onModelReady: (model, userId, userType) async{
        lessonCount = 0;
        courseCount = 0;
        _userType =await userType ?? UserType.Trainer;
        model.instructorCoursesModel.requestStatus = RequestStatus.loading;
        model.getInstructorCourseData(userId: userId!);
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
    if (provider.instructorCoursesModel.success != null) {
      print(provider.userId);
      return _listCourseClasses(provider.userId,
          data: provider.instructorCoursesModel.data!);
    } else if (provider.instructorCoursesModel.requestStatus == RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.CourseScreen);
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.instructorCoursesModel.requestStatus));
    }
  }

  // Widget _listCourseClassProvider(int userId,
  //     {required List<Datum> instructorCourseData}) {
  //   if (instructorCourseData != null &&
  //       instructorCourseData.length > 0) {
  //     return _listCourseClasses(userId,
  //         data: instructorCourseData);
  //   } else {
  //     return DataNotFound();
  //   }
  // }

  Widget _listCourseClasses(int userId,
      {required List<Datum> data}) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        // if (data.length > 0) {
        //   lessonCount = 0;
        //   courseCount = data.length;
        //   for (int i = 0; i < data.length; i++) {
        //     lessonCount = lessonCount! + listInstructorCourseDetails[i].data!;
        //   }
        // }
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
                  child: 
                   ItemInstructorCourse(
                    userId: userId,
                    userType: _userType,
                    model: data[index],
                    isCourse: true,
                  )
                  ),
            ),
        itemCount: data.length,
        options: animOption);
  }
}
