import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemUpcomingLiveScreen extends StatelessWidget {
  final UpcomingModel model;
  ItemUpcomingLiveScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.symmetric(vertical: 5),
      width: SizeConfig.screenWidth,
      child: Stack(
        children: [
          Container(
            height: 170,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: model.icon != null ? model.icon! : "",
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) =>
                    Image.asset(ic_generic_png),
              ),
            ),
          ),
          Positioned(
              bottom: 5,
              left: 50,
              right: 50,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [amber_600!, amber_400!]),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "${model.name}",
                        style: styleProvider(
                            color: black, fontWeight: bold, size: 14),
                      ),
                    ),
                    Text(
                      "${timeConverter(model.startTime != null ? model.startTime! : "13:00")} - ${timeConverter(model.endTime != null ? model.endTime! : "14:00")}",
                      style: styleProvider(
                          color: black, fontWeight: regular, size: 10),
                    )
                  ],
                ),
              )),
          Visibility(
              visible: model.status != null && model.status == "Upcoming",
              child: Positioned(
                child: new Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 38,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [amber_800!, amber_400!]),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            model.month != null ? model.month! : "01",
                            style: styleProvider(
                              size: 9,
                              color: black,
                              fontWeight: medium,
                            ),
                          ),
                          Text(
                            model.date != null ? model.date! : "01",
                            style: styleProvider(
                                size: 12, color: black, fontWeight: semiBold),
                          )
                        ],
                      )),
                ),
              )),
          Visibility(
              visible: model.status != null && model.status != "Upcoming",
              child: Positioned(
                child: new Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      height: 20,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [amber_800!, amber_400!]),
                        borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      ),
                      child: Text(
                        model.status != null && model.status != "Upcoming"
                            ? model.status!
                            : "Live",
                        style: styleProvider(
                            size: 12, color: black, fontWeight: semiBold),
                      )),
                ),
              )),
          Visibility(
            visible: model.status != null && model.status != "Upcoming",
            child: Align(
              alignment: Alignment.center,
              child: Positioned(
                  child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Icon(
                  Icons.play_circle_fill_sharp,
                  size: 45,
                  color: primaryColor,
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
