import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/review.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemReview extends StatelessWidget {
  final bool? isHome;
  final ReviewDetails model;
  ItemReview({Key? key, this.isHome, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isHome! ? 200 : MediaQuery.of(context).size.width - 100,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: reviewBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: isHome! ? 200 : MediaQuery.of(context).size.width,
            height: isHome! ? 35 : null,
            child: Text(
              "${model.review ?? "That was very nice"}",
              textAlign: TextAlign.start,
              style: styleProvider(size: 12, fontWeight: regular),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RatingBar(
              itemSize: 20,
              initialRating: model.rating ?? 0.0,
              minRating: 1,
              ignoreGestures: true,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 0),
              ratingWidget: RatingWidget(
                  full: new Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                  ),
                  half: new Icon(
                    Icons.star_half,
                    color: Theme.of(context).primaryColor,
                  ),
                  empty: new Icon(
                    Icons.star_border,
                    color: Theme.of(context).primaryColor,
                  )),
              onRatingUpdate: (rating) {
                print(rating);
              }),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(100)),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: model.avatar ?? thumbnail_user,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) => Image.asset(
                        moke_image3,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width:
                      isHome! ? 120 : MediaQuery.of(context).size.width - 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${model.name ?? "verified user"}",
                          overflow: TextOverflow.ellipsis,
                          style: styleProvider(size: 14, fontWeight: medium)),
                      Text("${model.product ?? "student"}",
                          overflow: TextOverflow.ellipsis,
                          style: styleProvider(
                              size: 10,
                              fontWeight: regular,
                              color: Theme.of(context).hintColor)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
