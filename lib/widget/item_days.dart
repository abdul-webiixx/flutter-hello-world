import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/days.dart';
import 'package:Zenith/utils/widget_helper.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDays extends StatefulWidget {
  final DaysData model;
  final ValueChanged<bool> isSelected;
  const ItemDays({Key? key, required this.model, required this.isSelected})
      : super(key: key);

  @override
  _ItemDaysState createState() => _ItemDaysState();
}

class _ItemDaysState extends State<ItemDays> {
  late bool checked;

  @override
  void initState() {
    checked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: GestureDetector(
              onTap: () {
                setState(() {
                  checked = !checked;
                });
                widget.isSelected(checked);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width / 2.6,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: checked
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).highlightColor),
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          widget.model.day!,
                          style: styleProvider(),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Time: ",
                              style: styleProvider(size: 8, color: grey),
                            ),
                            Text(
                              dateformating(widget.model.startTime!)!,
                              style: styleProvider(size: 8, color: grey),
                            ),
                            Text(
                              "-",
                              style: styleProvider(size: 8, color: grey),
                            ),
                            Text(
                              dateformating(widget.model.endTime!)!,
                              style: styleProvider(size: 8, color: grey),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))),
        ),
        Visibility(
            visible: checked,
            child: Positioned(
              right: 5,
              top: 5,
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Icon(
                    Icons.check_circle,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  )),
            ))
      ],
    );
  }

  String? dateformating(String date) {
    return DateFormat.jm()
        .format(DateFormat("hh:mm:ss").parse(date))
        .toString();
  }
}
