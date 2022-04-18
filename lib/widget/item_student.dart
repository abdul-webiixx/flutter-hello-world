import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/student.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class ItemStudent extends StatefulWidget {
  final StudentData model;
  final ClassViewModel classViewModel;
  final DateTime date;
  const ItemStudent(
      {Key? key,
      required this.model,
      required this.classViewModel,
      required this.date})
      : super(key: key);

  @override
  _ItemStudentState createState() => _ItemStudentState();
}

class _ItemStudentState extends State<ItemStudent> {
  late bool isAbsent;
  @override
  void initState() {
    isAbsent = widget.model.status == null || widget.model.status == "Absent";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
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
                      imageUrl: thumbnail_user,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Image.asset(
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
                    widget.model.name ?? "Test",
                    style: styleProvider(
                      size: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
          widget.date.day == DateTime.now().day
              ? Container(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isAbsent = false;
                          });
                          widget.classViewModel.getUpdateAttendance(
                              userId: widget.model.userId!,
                              classId: widget.model.classId!,
                              packageId: widget.model.packageId!,
                              date: dobDateFormatter(widget.date),
                              status: "Present");
                          // refresh(widget.classViewModel, widget.date);
                        },
                        child: isAbsent
                            ? Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: white)),
                                child: Icon(
                                  Icons.check,
                                  color: white,
                                  size: 18,
                                ),
                              )
                            : Container(
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
                              ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isAbsent = true;
                          });
                          widget.classViewModel.getUpdateAttendance(
                              userId: widget.model.userId!,
                              classId: widget.model.classId!,
                              packageId: widget.model.packageId!,
                              date: dobDateFormatter(widget.date),
                              status: "Absent");
                          // refresh(widget.classViewModel, widget.date);
                        },
                        child: isAbsent
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
              : isAbsent
                  ? Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: black,
                        size: 18,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: red,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: black,
                        size: 18,
                      ),
                    ),
        ],
      ),
    );
  }

  void refresh(ClassViewModel model, DateTime date) {
    model.getStudent(
        instructorId: model.userId,
        classId: widget.model.classId!,
        date: dobDateFormatter(date));
  }
}
