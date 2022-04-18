import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemHomeDanceCourse extends StatelessWidget {
  final DanceCourse model;
  ItemHomeDanceCourse({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 175,
      margin: EdgeInsets.only(right: 8),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [amber_700!, amberAccent]),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).dividerColor,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  child: CachedNetworkImage(
                    imageUrl: model.smallIcon != null ? model.smallIcon! : "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Image.asset(
                      ic_dance_girl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text("${getTitle(model.title)}",
                    style: styleProvider(fontWeight: bold, color: black)),
                Text(
                  "${getTitle(model.subTitle)}",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.0,
                      fontWeight: regular,
                      color: Color(0xFF4e4e4e)),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Text(
              "${getSubTitle(model.title)}",
              overflow: TextOverflow.ellipsis,
              style: styleProvider(
                  fontWeight: semiBold,
                  size: 10,
                  color: Theme.of(context).primaryColorLight),
            ),
          )
        ],
      ),
    );
  }

  getTitle(String? title) {
    if (title != null) {
      List<String> wordList = title.split(" ");
      if (wordList.isNotEmpty) {
        return "${wordList[0]} ${wordList[1]}";
      } else {
        return 'Dance Course';
      }
    } else {
      return "Dance Course";
    }
  }

  getSubTitle(String? tag) {
    if (tag != null) {
      List<String> wordList = tag.split(" ");
      if (wordList.isNotEmpty) {
        return "#${wordList[0].toLowerCase()}";
      } else {
        return '#belly';
      }
    } else {
      return "#belly";
    }
  }
}
