import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/instructor_profile.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemInstructorReview extends StatelessWidget {
  final ReviewData model;
  ItemInstructorReview({
    Key? key,
    required this.model,
  }) : super(key: key);

  String url_image = "";
  String? real_url =
      "https://zenithdance-images.s3.ap-south-1.amazonaws.com/users/default.png";
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
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: model.avatar.toString() ==
                                  "https://zenithdance-images.s3.ap-south-1.amazonaws.com/users/default.png"
                              ? thumbnail_user
                              : model.avatar!,
                          placeholder: (context, url) => Container(),
                          errorWidget: (context, url, error) =>
                              Image.network(thumbnail_user),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.name ?? "test",
                              textAlign: TextAlign.justify,
                              style: styleProvider(
                                  size: 12,
                                  color: Theme.of(context).primaryColorLight,
                                  fontWeight: regular),
                            ),
                            Text(
                              timeago.format(model.updatedAt!),
                              style: styleProvider(
                                  size: 10,
                                  color: Theme.of(context).hintColor,
                                  fontWeight: medium),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 70,
                          child: RatingBar(
                              itemSize: 20,
                              initialRating: model.rating,
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
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          model.review!,
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
          ],
        ));
  }
}
