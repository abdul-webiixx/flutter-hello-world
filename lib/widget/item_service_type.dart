import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemServiceType extends StatelessWidget {
  final SingleClass model;
  ItemServiceType({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: SizeConfig.widthMultiplier! * 40,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: CachedNetworkImage(
              imageUrl: model.icon ?? "",
              placeholder: (context, url) => Container(),
              errorWidget: (context, url, error) => Image.asset(moke_image3),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            model.name,
            style: styleProvider(
              size: 12,
              fontWeight: medium,
            ),
          )
        ],
      ),
    );
  }
}
