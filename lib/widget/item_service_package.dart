import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/service_package.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemServicePackage extends StatelessWidget {
  final MonthList model;
  ItemServicePackage({Key? key, required this.model});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).highlightColor,
          ),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "No. of Classes: ${model.totalClasses}",
                    style: styleProvider(size: 12, fontWeight: regular),
                  ),
                  Text(
                    "Price: ${model.totalCost}",
                    style: styleProvider(size: 12, fontWeight: regular),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin: EdgeInsets.symmetric(vertical: 10),
                width: SizeConfig.widthMultiplier! * 35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [amber_700!, amber_400!]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "${model.monthName}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: semiBold,
                            color: Theme.of(context).backgroundColor,
                            height: 0.77),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "${model.days} days/weeks",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: regular,
                              color: Theme.of(context).backgroundColor,
                              height: 0.77),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
