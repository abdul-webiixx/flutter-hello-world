import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/search.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemSearch extends StatelessWidget {
  final SearchData model;
  ItemSearch({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: highlightColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 60,
              width: 80,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: CachedNetworkImage(
                      imageUrl: model.image != null ? model.image! : "",
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Image.asset(
                        moke_image2,
                      ),
                    ),
                  ),
                ),
              )),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width - 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child: Text(
                    model.name!,
                    style: styleProvider(
                        color: Theme.of(context).primaryColorLight,
                        size: 12,
                        fontWeight: regular),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: 5.0,
                        minWidth: 5.0,
                        maxHeight: 45.0,
                        maxWidth: 45.0,
                      ),
                      child: Text(
                        model.desc != null ? "${model.desc}" : "",
                        style: styleProvider(
                            color: Theme.of(context).hintColor,
                            size: 10,
                            fontWeight: regular),
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
