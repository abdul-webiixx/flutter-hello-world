import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemHomeUpcomingLiveClass extends StatelessWidget {
  final UpcomingModel model;
  ItemHomeUpcomingLiveClass({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 5),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.amber,
        gradient: backgroundColorUpdater(
            isLive(int.parse(model.date!), model.month!)),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Icon(
                      CustomIcons.live_streaming,
                      size: 30,
                      color: isLive(int.parse(model.date!), model.month!)
                          ? white
                          : black,
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: playColorUpdater(
                        isLive(int.parse(model.date!), model.month!)),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  Icons.play_arrow,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _nameProvider(model.name!),
                    style: styleProvider(
                        size: 14,
                        fontWeight: semiBold,
                        color: isLive(int.parse(model.date!), model.month!)
                            ? black
                            : white),
                  ),
                ),
                Text(
                  "${timeConverter(model.startTime!)} - ${timeConverter(model.endTime!)}",
                  style: styleProvider(
                      size: 8,
                      fontWeight: bold,
                      color: isLive(int.parse(model.date!), model.month!)
                          ? black
                          : white),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 100,
                  child: new Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: dateColorUpdater(
                            isLive(int.parse(model.date!), model.month!)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "${model.date} ${model.month}",
                          style: styleProvider(
                              fontWeight: semiBold,
                              size: 10,
                              color:
                                  isLive(int.parse(model.date!), model.month!)
                                      ? white
                                      : black),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _nameProvider(String name) {
    List<String> wordList = name.split(" ");

    if (wordList.isNotEmpty && wordList.length > 4) {
      return "${wordList[3]} ${wordList[4]}";
    } else if (wordList.isNotEmpty) {
      return name;
    } else {
      return "Dance Form";
    }
  }

  bool isLive(int day, String month) {
    var currentDay = DateTime.now().day;
    var format = DateFormat("MMMM");
    var currentMonth = format.format(DateTime.now());
    if (currentDay == day && currentMonth.substring(0, 3) == month) {
      return true;
    } else {
      return false;
    }
  }

  LinearGradient backgroundColorUpdater(bool? status) {
    if (status != null && !status) {
      return LinearGradient(colors: [highlightColor, highlightColor]);
    } else {
      return LinearGradient(colors: [Colors.amber[600]!, Colors.amber[400]!]);
    }
  }

  LinearGradient dateColorUpdater(bool? status) {
    if (status != null && !status) {
      return LinearGradient(colors: [Colors.amber[600]!, Colors.amber[400]!]);
    } else {
      return LinearGradient(colors: [black, black]);
    }
  }

  LinearGradient playColorUpdater(bool? status) {
    if (status != null && !status) {
      return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.amber[600]!, Colors.amber[400]!]);
    } else {
      return LinearGradient(colors: [black, black]);
    }
  }
}
