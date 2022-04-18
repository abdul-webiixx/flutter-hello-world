import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemHomeInstructor extends StatelessWidget {
  final Instructor model;
  ItemHomeInstructor({
    Key? key,
    required this.model,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, bottom: 5),
      width: 130,
      height: 200,
      color: black,
      child: Stack(
        children: [
          Container(
              width: 130,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).highlightColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: model.avatar.toString() ==
                          "https://zenithdance-images.s3.ap-south-1.amazonaws.com/users/default.png"
                      ? thumbnail_user_home
                      : model.avatar!,
                  placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => Image.asset(
                    moke_image1,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          new Positioned(
            right: 20,
            bottom: 5,
            left: 20,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [amber_600!, amber_400!]),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Text(
                _nameProvider(model.name!),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styleProvider(
                    fontWeight: semiBold,
                    size: 10,
                    color: Theme.of(context).backgroundColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  String _nameProvider(String name) {
    List<String> wordList = name.split(" ");
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return 'Instructor';
    }
  }
}
