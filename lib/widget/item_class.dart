import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemClasses extends StatelessWidget {
  final SingleClass model;
  final bool? isStatic;
  ItemClasses({Key? key, required this.model, this.isStatic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  height: SizeConfig.widthMultiplier! * 20,
                  width: SizeConfig.widthMultiplier! * 20,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [amber_700!, amber_400!]),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: isStatic != null && isStatic!
                        ? model.avatar!
                        : model.icon != null
                            ? model.icon!
                            : "",
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) =>
                        Image.asset(ic_dance_girl),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth! - 200,
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.name,
                          style: styleProvider(
                              fontWeight: medium,
                              size: 14,
                              color: Theme.of(context).primaryColorLight)),
                      Container(
                        width: 150,
                        child: Text(model.description,
                            style: styleProvider(
                                fontWeight: thin,
                                size: 12,
                                color: Theme.of(context).hintColor)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [amber_700!, amber_400!]),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Theme.of(context).backgroundColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
