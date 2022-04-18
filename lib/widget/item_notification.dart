import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/notification.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemNotification extends StatefulWidget {
  final NotificationDetails model;
  ItemNotification({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  _ItemNotificationState createState() => _ItemNotificationState();
}

class _ItemNotificationState extends State<ItemNotification> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: highlightColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
              width: SizeConfig.widthMultiplier! * 15,
              height: SizeConfig.widthMultiplier! * 15,
              child: widget.model.avatar != null
                  ? CachedNetworkImage(
                      imageUrl: widget.model.avatar != null
                          ? widget.model.avatar!
                          : "",
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Image.asset(
                        moke_image1,
                        fit: BoxFit.fill,
                      ),
                    )
                  : streamWidget(context)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10),
              width: SizeConfig.widthMultiplier! * 62,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${widget.model.description}",
                      style: styleProvider(size: 12, fontWeight: regular)),
                  Text(
                      widget.model.createdAt != null
                          ? dateTimeConverter(widget.model.createdAt!)
                          : "",
                      style: styleProvider(
                          size: 10,
                          fontWeight: regular,
                          color: Theme.of(context).hintColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String add(int n) {
    return n.toString().padLeft(2, '0');
  }
}
