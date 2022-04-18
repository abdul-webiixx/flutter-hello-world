import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemInstructorUpcoming extends StatelessWidget {
  final UpcomingModel model;
  const ItemInstructorUpcoming({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 5),
      decoration: BoxDecoration(
          color: highlightColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name ?? "Test",
                  style: styleProvider(size: 12),
                ),
                Text(
                  model.serviceName ?? "Workshop",
                  style: styleProvider(size: 10, color: grey, fontWeight: thin),
                ),
                Text(
                  "Time: ${timeConverter(model.startTime ?? "00")} - ${timeConverter(model.endTime ?? "00")}",
                  style: styleProvider(size: 10, color: grey, fontWeight: thin),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [amber_600!, amber_400!]),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                children: [
                  Text(
                    model.month ?? "00",
                    style: styleProvider(
                      size: 10,
                      color: black,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    model.date ?? "00",
                    style:
                        styleProvider(size: 16, color: black, fontWeight: bold),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
