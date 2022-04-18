import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/model/student.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:Zenith/widget/item_student.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'oops.dart';

class AttendanceScreen extends StatefulWidget {
  final int classId;
  const AttendanceScreen({Key? key, required this.classId}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late DateTime _currentDate;
  late UserViewModel _userViewModel;
  late FirebaseService _firebaseService;
  late bool isAbsent;
  @override
  void initState() {
    super.initState();
    isAbsent = true;
    _firebaseService = new FirebaseService();
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      _currentDate = DateTime.now();
      model.resetBuilder();
      model.getStudent(
          instructorId: model.userId,
          classId: widget.classId,
          date: dobDateFormatter(_currentDate));
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
          title: "Attendance",
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: highlightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  dateFormatter(_currentDate),
                                  style: styleProvider(
                                      size: 12,
                                      fontWeight: medium,
                                      color: Theme.of(context).hintColor),
                                ),
                                InkWell(
                                  onTap: () {
                                    _dialogCalender(model);
                                  },
                                  child: Icon(
                                    CustomIcons.calendar,
                                    color: Theme.of(context).hintColor,
                                    size: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 10),
                          height: MediaQuery.of(context).size.height,
                          width: 40,
                          decoration: BoxDecoration(
                            color: highlightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              _getUserData(model);
                            },
                            child: Icon(
                              Icons.add,
                              color: Theme.of(context).hintColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: _listStudentProvider(model))
                ],
              ),
            ),
            model.state == ViewState.Busy
                ? new Align(
                    alignment: Alignment.center,
                    child: LoadingView(),
                  )
                : Container(),
          ],
        ),
      );
    });
  }

  Widget _listStudentProvider(ClassViewModel provider) {
    if (provider.studentModel.success != null &&
        provider.studentModel.success) {
      return _listStudentBuilder(
          studentModel: provider.studentModel, model: provider);
    } else if (provider.studentModel.requestStatus == RequestStatus.loading) {
      return ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Shimmer(shimmerFor: ShimmerFor.Choreography);
          });
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.studentModel.requestStatus));
    }
  }

  Widget _listStudentBuilder(
      {required StudentModel studentModel, required ClassViewModel model}) {
    if (studentModel.studentList != null &&
        studentModel.studentList!.length > 0) {
      return _listStudent(listStudent: studentModel.studentList!, model: model);
    } else {
      return DataNotFound();
    }
  }

  Widget _listStudent(
      {required List<StudentData> listStudent, required ClassViewModel model}) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: highlightColor,
          borderRadius: BorderRadius.circular(10),
        ),
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
                      child: ItemStudent(
                          model: listStudent[index],
                          date: _currentDate,
                          classViewModel: model)),
                ),
            itemCount: listStudent.length,
            options: animOption));
  }

  void _dialogCalender(ClassViewModel model) {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.3),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: new Align(
              alignment: Alignment.center,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(20),
                  height: 420,
                  decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: CalendarCarousel<Event>(
                    todayBorderColor: Theme.of(context).primaryColor,
                    daysHaveCircularBorder: false,
                    dayPadding: 4,
                    showOnlyCurrentMonthDate: false,
                    weekendTextStyle: styleProvider(
                      color: Colors.white,
                    ),
                    selectedDayBorderColor: Theme.of(context).primaryColor,
                    selectedDayButtonColor: Theme.of(context).primaryColor,
                    thisMonthDayBorderColor: transparent,
                    weekFormat: false,
                    height: 420.0,
                    customDayBuilder: (
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                    ) {
                      if (isToday) {
                        return Center(
                          child: Icon(
                            CustomIcons.dance,
                            color: Theme.of(context).backgroundColor,
                          ),
                        );
                      } else {
                        return null;
                      }
                    },
                    selectedDateTime: _currentDate,
                    targetDateTime: _currentDate,
                    customGridViewPhysics: NeverScrollableScrollPhysics(),
                    markedDateCustomShapeBorder:
                        RoundedRectangleBorder(side: BorderSide(color: white)),
                    showHeader: true,
                    todayButtonColor: Colors.yellow,
                    weekdayTextStyle: styleProvider(color: Colors.white),
                    selectedDayTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    inactiveWeekendTextStyle: styleProvider(
                        color: Theme.of(context).primaryColorLight),
                    daysTextStyle: styleProvider(
                        color: Theme.of(context).primaryColorLight),
                    headerTextStyle: styleProvider(
                        color: Theme.of(context).primaryColorLight),
                    dayButtonColor: Colors.grey[800]!,
                    minSelectedDate: _currentDate.subtract(Duration(days: 360)),
                    maxSelectedDate: _currentDate.add(Duration(days: 360)),
                    prevDaysTextStyle: styleProvider(
                      color: Colors.grey[800],
                    ),
                    nextDaysTextStyle: styleProvider(
                      color: Colors.black,
                    ),
                    iconColor: white,
                    inactiveDaysTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    onDayPressed: (DateTime date, List<Event> events) {
                      if (date.isAfter(DateTime.now())) {
                        showToast(context, msg: "Not a valid date");
                        backToScreen(context);
                      } else {
                        refresh(model, date);
                        Navigator.pop(context);
                      }
                    },
                    todayTextStyle: styleProvider(color: Colors.amber),
                    markedDateCustomTextStyle: styleProvider(),
                    onDayLongPressed: (DateTime date) {},
                  )),
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

  void _getUserData(ClassViewModel model) {
    showGeneralDialog(
        barrierLabel: "add_attendance",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.3),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: new Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                height: 200,
                decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Student Id", style: styleProvider()),
                          InkWell(
                            onTap: () {
                              backToScreen(context);
                            },
                            child: Icon(Icons.close),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .hintColor
                                .withOpacity(0.5), // set border color
                            width: 1), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // set rounded corner radius
                      ),
                      child: TextField(
                        controller: _userViewModel.studentIdController,
                        decoration: InputDecoration(
                          hintText: 'Student Id',
                          suffixIcon: Container(
                            width: 10,
                            child: Row(
                              children: [
                                model.state == ViewState.Busy
                                    ? Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ))
                                    : Container()
                              ],
                            ),
                          ),
                          hintStyle:
                              styleProvider(color: Theme.of(context).hintColor),
                          border: InputBorder.none,
                        ),
                        style: styleProvider(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        onPressed: () {
                          if (_userViewModel
                              .formValidator(ValidationFor.Attendance)) {
                            model.state = ViewState.Busy;
                            _userViewModel
                                .getProfileData(
                                    userId: int.parse(_userViewModel
                                        .studentIdController.text))
                                .then((value) {
                              if (value.success &&
                                  value.userInformation != null) {
                                _updateUserAttendance(
                                    model, value.userInformation!);
                              } else {
                                showToast(
                                  context,
                                  msg: value.message ?? "User Not Found",
                                  bgColor: Theme.of(context).errorColor,
                                );
                              }
                              model.state = ViewState.Idle;
                            }).onError((error, stackTrace) {
                              model.state = ViewState.Idle;
                              _firebaseService.firebaseJsonError(
                                  apiCall: "getProfileData",
                                  stackTrace: stackTrace,
                                  message: error.toString(),
                                  userId:
                                      _userViewModel.studentIdController.text);
                              showToast(context, msg: error.toString());
                            });
                          } else {
                            showToast(context,
                                msg: _userViewModel.autoValidationError!);
                          }
                        },
                        title: "SUBMIT")
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

  void _updateUserAttendance(
      ClassViewModel model, UserInformation userInformation) {
    showGeneralDialog(
        barrierLabel: "add_attendance",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.3),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return AttendanceDialog(
            model: model,
            classId: widget.classId,
            date: _currentDate,
            userInfo: userInformation,
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

  void refresh(ClassViewModel model, DateTime date) {
    setState(() {
      _currentDate = date;
      model.state = ViewState.Busy;
      model
          .getStudent(
              instructorId: model.userId,
              classId: widget.classId,
              date: dobDateFormatter(_currentDate))
          .then((value) => model.state = ViewState.Idle)
          .onError((error, stackTrace) => model.state = ViewState.Idle);
    });
  }
}

class AttendanceDialog extends StatefulWidget {
  final UserInformation userInfo;
  final ClassViewModel model;
  final DateTime date;
  final int classId;
  const AttendanceDialog(
      {Key? key,
      required this.classId,
      required this.userInfo,
      required this.model,
      required this.date})
      : super(key: key);

  @override
  _AttendanceDialogState createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  late FirebaseService _firebaseService;
  @override
  void initState() {
    _firebaseService = new FirebaseService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: new Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          height: 210,
          decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Student Id", style: styleProvider()),
                    InkWell(
                      onTap: () {
                        backToScreen(context);
                      },
                      child: Icon(Icons.close),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.userInfo.avatar ?? thumbnail_user,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  moke_image3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 200,
                            child: Text(
                              widget.userInfo.name ?? "Test",
                              style: styleProvider(
                                size: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                setState(() {
                                  widget.model.setStudentPresent(true);
                                });
                              },
                              child: widget.model.studentPresent != null &&
                                      widget.model.studentPresent!
                                  ? Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          color: green,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: green)),
                                      child: Icon(
                                        Icons.check,
                                        color: black,
                                        size: 18,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: white)),
                                      child: Icon(
                                        Icons.check,
                                        color: white,
                                        size: 18,
                                      ),
                                    )),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                widget.model.setStudentPresent(false);
                              });
                            },
                            child: widget.model.studentPresent != null &&
                                    !widget.model.studentPresent!
                                ? Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        color: red,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: red)),
                                    child: Icon(
                                      Icons.close,
                                      color: black,
                                      size: 18,
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(color: white)),
                                    child: Icon(
                                      Icons.close,
                                      size: 18,
                                    ),
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
              CustomButton(
                  onPressed: () {
                    if (widget.model.studentPresent != null) {
                      widget.model
                          .getManualAttendance(
                              userId: widget.userInfo.id!,
                              classId: widget.classId,
                              date: dobDateFormatter(widget.date),
                              status: widget.model.studentPresent!
                                  ? "Present"
                                  : "Absent")
                          .then((value) {
                        if (value.success) {
                          backToScreen(context);
                          backToScreen(context);
                          showToast(
                            context,
                            msg: value.message!,
                          );
                        } else {
                          showToast(context,
                              msg: value.message!,
                              bgColor: Theme.of(context).errorColor);
                        }
                      }).onError((error, stackTrace) {
                        _firebaseService.firebaseJsonError(
                          apiCall: "getManualAttendance",
                          stackTrace: stackTrace,
                          message: error.toString(),
                          userId: widget.userInfo.id,
                        );
                      });
                    } else {
                      showToast(context,
                          msg: select_attendance,
                          bgColor: Theme.of(context).errorColor);
                    }
                  },
                  title: "SUBMIT")
            ],
          ),
        ),
      ),
    );
  }
}
