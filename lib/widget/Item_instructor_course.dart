import 'package:Zenith/model/course.dart';
import 'package:Zenith/model/instructor_courses.dart';
import 'package:Zenith/screen/add_course.dart';
import 'package:Zenith/screen/course_choreography.dart';
import 'package:Zenith/screen/instructor_lesson.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/screen/course_lesson.dart';
import 'package:Zenith/screen/course_package.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:provider/provider.dart';

class ItemInstructorCourse extends StatefulWidget {
  final Datum model;
  final bool isCourse;
  final UserType userType;
  final int userId;
  ItemInstructorCourse({
    Key? key,
    required this.model,
    required this.userId,
    required this.isCourse,
    required this.userType
  }) : super(key: key);

  @override
  _ItemInstructorCourseState createState() => _ItemInstructorCourseState();
}

class _ItemInstructorCourseState extends State<ItemInstructorCourse> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      margin: EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      height: 225,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 120,
                padding: EdgeInsets.only(bottom: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isCourse
                          ? widget.model.title!
                          : widget.model.name!,
                      maxLines: 1,
                      style: styleProvider(),
                    ),
                    Text(
                      widget.isCourse
                          ? "${widget.model.description} Choregraphy"
                          : "${widget.model.description!}",
                      maxLines: 1,
                      style: styleProvider(
                          size: 12, fontWeight: thin, color: grey),
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: widget.isCourse,
                  child: InkWell(
                    onTap: ()
                    //  {},
                     {
                    //   if (widget.userType == UserType.Trainer) {
                    //     if (widget.model.subscriptionStatus != null &&
                    //         widget.model.subscriptionStatus == "Active") {
                    //       showToast(context, msg: "Already Subscribed");
                    //     } else {
                    //       changeScreen(
                    //           context,
                    //           CoursePackageScreen(
                    //             courseId: widget.model.id!,
                    //             title: widget.model.title!,
                    //           ));
                    //     }
                    //   } else {
                        changeScreen(
                            context,
                            AddNewCourses(
                              model: widget.model,
                            ));
                    //   }
                    },
                  
                    child: Container(
                      width: 70,
                      height: 20,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: colorUpdater(),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Center(
                          child: Text("Add New",
                        // textUpdater(
                        //   // widget.model.subscriptionStatus,
                        //     widget.userType),
                        style: styleProvider(
                            color: black, fontWeight: medium, size: 10),
                      )
                      ),
                    ),
                  ))
            ],
          ),
          Container(
              height: 170,
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: widget.isCourse
                              ? widget.model.featuredImage!
                              : widget.model.image ?? "",
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) => Image.asset(
                            moke_image4,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
                  Align(
                      alignment: Alignment.center,
                      child: MaterialButton(
                        onPressed: () {
                          if (widget.isCourse) {
                            changeScreen(
                                context,
                                CourseChoreography(
                                  title: widget.model.title!,
                                  courseId: widget.model.id!,
                                ));
                          } else {
                            if (widget.userType == UserType.Student) {
                              changeScreen(
                                  context,
                                  CourseLessonScreen(
                                    userId: widget.userId,
                                    courseId: widget.model.courseId!,
                                    packageId: 1,
                                    title: widget.model.name!,
                                    choreographyId: widget.model.id!,
                                  ));
                            } else {
                              changeScreen(
                                  context,
                                  InstructorLessonScreen(
                                    choreographyId: widget.model.id!,
                                  ));
                            }
                          }
                        },
                        child: SvgPicture.asset(
                          ic_vplay,
                          height: 60,
                          width: 60,
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
 
 
  }

  LinearGradient colorUpdater() {
    // if (status != null && status == "Active") {
    //   return LinearGradient(colors: [Colors.green[600]!, Colors.green[600]!]);
    // } else {
      return LinearGradient(colors: [Colors.amber[800]!, Colors.amber[400]!]);
    }


  String textUpdater(UserType userType) {
    // if (userType == UserType.Student) {
    //   if (status != null && status == "Active") {
    //     return "Subscribed";
    //   } else {
    //     return "Buy Now";
    //   }
    // } else {
      return 
      "Add New";
    }
  }

