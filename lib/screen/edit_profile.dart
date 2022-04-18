import 'dart:io';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart' as ChartEvent;
import 'package:intl/intl.dart' show DateFormat;
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

import 'instructor_home.dart';

class EditProfileScreen extends StatefulWidget {
  final UserInformation model;
  EditProfileScreen({Key? key, required this.model}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late FirebaseService _firebaseService;
  String? gender;
  late int _lastYear = DateTime.now().year - 18;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String? imagePath;
  final ImagePicker _imagePicker = new ImagePicker();

  @override
  void initState() {
    _firebaseService = new FirebaseService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildUi(UserViewModel model) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: imagePath != null && imagePath!.isNotEmpty
                          ? Image.file(
                              File(imagePath!),
                              fit: BoxFit.fill,
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.model.avatar ?? thumbnail_user,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => Image.asset(
                                moke_image3,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  new Positioned(
                      bottom: 15,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          imagePicker(context, model);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            CustomIcons.edit,
                            color: Theme.of(context).backgroundColor,
                            size: 15,
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                margin: EdgeInsets.symmetric(vertical: 25),
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Profile Details",
                        style: styleProvider(
                            fontWeight: semiBold,
                            size: 16,
                            color: Theme.of(context).primaryColorLight)),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.amber[700]!,
                                        Colors.amberAccent[200]!
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Icon(
                                  CustomIcons.user,
                                  color: Theme.of(context).backgroundColor,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width - 130,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    suffix: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: "Name",
                                    labelStyle: styleProvider(
                                        fontWeight: medium,
                                        size: 14,
                                        color: Theme.of(context).hintColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: model.nameController,
                                  style: styleProvider(
                                      fontWeight: regular,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(
                                    top: 7, left: 5, right: 10, bottom: 7),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.amber[700]!,
                                        Colors.amberAccent[200]!
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Icon(
                                  CustomIcons.email,
                                  color: Theme.of(context).backgroundColor,
                                  size: 12,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width - 130,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    suffix: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: "Email Address",
                                    labelStyle: styleProvider(
                                        fontWeight: medium,
                                        size: 14,
                                        color: Theme.of(context).hintColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: model.emailController,
                                  style: styleProvider(
                                      fontWeight: regular,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.amber[700]!,
                                      Colors.amberAccent[200]!
                                    ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Icon(
                                CustomIcons.sex,
                                color: Theme.of(context).backgroundColor,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width - 130,
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color:
                                                Theme.of(context).hintColor))),
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  focusColor: Colors.white,
                                  value:
                                      isValidString(model.genderController.text)
                                          ? model.genderController.text
                                          : gender,
                                  style: styleProvider(),
                                  iconEnabledColor: Colors.black,
                                  items: <String>[
                                    'Male',
                                    'Female',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: styleProvider(),
                                      ),
                                    );
                                  }).toList(),
                                  icon: Container(),
                                  hint: Text(
                                    "Gender",
                                    style: styleProvider(
                                        color: Theme.of(context).hintColor),
                                  ),
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      setState(() {
                                        model.genderController.text = value;
                                        gender = value;
                                      });
                                    }
                                  },
                                ))
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.amber[700]!,
                                        Colors.amberAccent[200]!
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Icon(
                                  CustomIcons.placeholder,
                                  color: Theme.of(context).backgroundColor,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width - 130,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    suffix: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        Icons.check,
                                        size: 20,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    labelText: "Address",
                                    labelStyle: styleProvider(
                                        fontWeight: medium,
                                        size: 14,
                                        color: Theme.of(context).hintColor),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                  controller: model.address1Controller,
                                  style: styleProvider(
                                      fontWeight: regular,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      size: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.amber[700]!,
                                        Colors.amberAccent[200]!
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                                child: Icon(
                                  CustomIcons.cake,
                                  color: Theme.of(context).backgroundColor,
                                  size: 15,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _birthDateDialog(model);
                                },
                                child: Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      counterText: "",
                                      suffix: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Icon(
                                          Icons.check,
                                          size: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      labelText: "Date of Birth",
                                      labelStyle: styleProvider(
                                          fontWeight: medium,
                                          size: 14,
                                          color: Theme.of(context).hintColor),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).hintColor),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).hintColor),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).hintColor),
                                      ),
                                      hintText: "1990/09/12",
                                    ),
                                    controller: model.dobController,
                                    maxLength: 10,
                                    enabled: false,
                                    keyboardType: TextInputType.datetime,
                                    style: styleProvider(
                                        fontWeight: regular,
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        size: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  void _onImageButtonPressed(ImageSource source, UserViewModel model) async {
    final pickedFile = await _imagePicker.pickImage(
      source: source,
      maxWidth: 100,
      maxHeight: 100,
      imageQuality: 100,
    );
    model.state = ViewState.Busy;
    model
        .getProfilePicUpdate(
            userId: widget.model.id!,
            fileName: "${widget.model.id!}pic",
            filePath: pickedFile!.path)
        .then((value) {
      if (value) {
        model.state = ViewState.Idle;
        showToast(context, msg: "profile pic updated");
        model.clearAllModels();
        changeScreen(context, MainScreen(currentTab: 0));
      }
    }).onError((error, stackTrace) {
      model.state = ViewState.Idle;
      _firebaseService.firebaseJsonError(
          apiCall: "fetchUpdateProfilePic",
          stackTrace: stackTrace,
          message: error.toString(),
          userId: widget.model.id!);
    });

    setState(() {
      imagePath = pickedFile.path;
    });
  }

  void imagePicker(BuildContext context, UserViewModel model) {
    showGeneralDialog(
        barrierLabel: "image picker",
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
                height: 150,
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
                          Icon(CustomIcons.user),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Profile Image", style: styleProvider()),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Divider(
                      height: 2,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButtonTransparent(
                            onPressed: () {
                              _onImageButtonPressed(ImageSource.gallery, model);
                              backToScreen(context);
                            },
                            title: "Gallery",
                            color: Theme.of(context).primaryColorLight,
                            width: MediaQuery.of(context).size.width / 2 - 50,
                          ),
                          CustomButton(
                            onPressed: () {
                              _onImageButtonPressed(ImageSource.camera, model);
                              backToScreen(context);
                            },
                            title: "Camera",
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

  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(
        onModelReady: (model, userId, userType) {
      model.nameController.text = widget.model.name ?? "";
      model.emailController.text = widget.model.email ?? "user@mail.com";
      model.address1Controller.text = widget.model.address1 ?? "";
      model.dobController.text =
          widget.model.dob != null ? widget.model.dob! : "2010/01/01";
      model.genderController.text = widget.model.gender ?? "";
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          title: "Edit Account",
          isLeading: true,
        ),
        body: Stack(
          children: [
            buildUi(model),
            model.state == ViewState.Busy
                ? new Align(
                    alignment: Alignment.center,
                    child: LoadingView(
                      msg: "Updating Profile...",
                    ),
                  )
                : Container(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 70,
          padding: EdgeInsets.only(bottom: 20),
          child: CustomButton(
            title: "Submit",
            onPressed: model.state == ViewState.Busy
                ? null
                : () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    if (gender != null) {
                      model.genderController.text = gender!;
                    }
                    model.keyBoardDismiss(context);
                    if (model.formValidator(ValidationFor.EditProfile)) {
                      model.state = ViewState.Busy;
                      model
                          .getProfileDataUpdate(
                              userId: widget.model.id!,
                              name: model.nameController.text.toString().trim(),
                              email:
                                  model.emailController.text.toString().trim(),
                              address: model.address1Controller.text
                                  .toString()
                                  .trim(),
                              gender:
                                  model.genderController.text.toString().trim(),
                              dob: model.dobController.text.toString().trim())
                          .then((value) {
                        model.state = ViewState.Idle;
                        showToast(context, msg: value.message!);
                        model.clearAllModels();
                        if (value.success != null && value.success!) {
                          if (value.userInformation!=null && value.userInformation!.roleId! == 3) {
                            changeToNewScreen(context, InstructorHomeScreen(),
                                "InstructorHome");
                          } else {
                            changeToNewScreen(
                                context,
                                MainScreen(
                                  currentTab: 0,
                                ),
                                "mainPge");
                          }
                        }
                      }).onError((error, stackTrace) {
                        model.state = ViewState.Idle;
                        _firebaseService.firebaseJsonError(
                            apiCall: "fetchProfileDataUpdate",
                            message: error.toString(),
                            stackTrace: stackTrace,
                            userId: null);
                      });
                    } else {
                      showToast(context,
                          msg: model.autoValidationError ?? "Please fill above details",
                          textStyle: styleProvider(size: 12,),
                          bgColor: Theme.of(context).errorColor, duration: 2);
                    }
                  },
          ),
        ),
      );
    });
  }

  void _birthDateDialog(UserViewModel model) {
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
                      color: highlightColor,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: CalendarCarousel<ChartEvent.Event>(
                    todayBorderColor: primaryColor,
                    daysHaveCircularBorder: false,
                    dayPadding: 4,
                    showOnlyCurrentMonthDate: false,
                    weekendTextStyle: styleProvider(
                      color: Colors.white,
                    ),
                    selectedDayBorderColor: primaryColor,
                    selectedDayButtonColor: primaryColor,
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
                            Icons.wine_bar,
                            color: black,
                          ),
                        );
                      } else {
                        return null;
                      }
                    },
                    selectedDateTime: DateTime(_lastYear),
                    targetDateTime: DateTime(_lastYear),
                    customGridViewPhysics: NeverScrollableScrollPhysics(),
                    markedDateCustomShapeBorder:
                        RoundedRectangleBorder(side: BorderSide(color: white)),
                    showHeader: true,
                    todayButtonColor: Colors.yellow,
                    weekdayTextStyle: styleProvider(color: Colors.white),
                    selectedDayTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    inactiveWeekendTextStyle: styleProvider(color: white),
                    daysTextStyle: styleProvider(color: white),
                    headerTextStyle: styleProvider(color: white),
                    dayButtonColor: Colors.grey[800]!,
                    minSelectedDate: DateTime(_lastYear - 50),
                    maxSelectedDate: DateTime(_lastYear + 2),
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
                    onDayPressed:
                        (DateTime date, List<ChartEvent.Event> events) {
                      setState(() {
                        model.dobController.text = dobDateFormatter(date);
                      });
                      backToScreen(context);
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
}
