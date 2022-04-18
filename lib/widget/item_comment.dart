import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/comment_details.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:Zenith/utils/widget_helper.dart';

class ItemComments extends StatelessWidget {
  final Comment model;
  ItemComments({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: primaryColor, width: 2)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: model.avatar!,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                              Image.network(thumbnail_user),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.name!,
                          textAlign: TextAlign.justify,
                          style: styleProvider(
                              size: 12,
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: regular),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.comment!,
                          style: styleProvider(
                              size: 10,
                              color: Theme.of(context).hintColor,
                              fontWeight: regular),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              timeago.format(model.updatedAt!),
              style: styleProvider(
                  size: 10,
                  color: Theme.of(context).hintColor,
                  fontWeight: medium),
            ),
          ],
        ));
  }
}
