import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/course_lesson.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemCourseLesson extends StatelessWidget {
  final CourseLessonPackageDetails model;
  ItemCourseLesson({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  "${model.title ?? "test"}",
                  style: styleProvider(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: 200,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: model.thumbnail ?? "",
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Image.asset(
                      moke_image3,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              new Positioned(
                  top: 0,
                  bottom: 0,
                  child: new Align(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [amber_800!, amber_600!]),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Icon(
                        iconProvider(
                            subscribe: model.subscription,
                            previewLesson: model.previewLesson),
                        color: black,
                        size: 20,
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  IconData iconProvider({dynamic subscribe, dynamic previewLesson}) {
    if (previewLesson != 0) {
      return Icons.play_arrow;
    } else if (subscribe == null) {
      return CustomIcons.lock;
    } else if (subscribe == "active") {
      return Icons.play_arrow;
    } else {
      return Icons.play_arrow;
    }
  }
}
