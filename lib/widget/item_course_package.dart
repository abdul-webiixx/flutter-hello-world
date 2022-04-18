import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/course_package.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemCoursePackageSubscriptions extends StatelessWidget {
  final CoursePackageDetails model;
  ItemCoursePackageSubscriptions({Key? key, required this.model})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Theme.of(context).highlightColor,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${model.duration} ${model.type}",
              style: styleProvider(size: 14, fontWeight: semiBold),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${model.description != null ? model.description : "Not Available"}",
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: styleProvider(size: 12, fontWeight: regular),
                          ),
                          Text("data")
                        ],
                      )),
                  Container(
                      height: 70,
                      width: SizeConfig.widthMultiplier! * 30,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [amber_700!, amber_400!]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "₹ ${model.price}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: semiBold,
                              color: Theme.of(context).backgroundColor,
                              height: 0.77),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
