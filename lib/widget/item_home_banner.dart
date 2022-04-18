import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/screen/banner_show.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

class ItemHomeBanner extends StatefulWidget {
  final BannerClass model;
  const ItemHomeBanner({Key? key, required this.model}) : super(key: key);

  @override
  _ItemHomeBannerState createState() => _ItemHomeBannerState();
}

class _ItemHomeBannerState extends State<ItemHomeBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ItemPageBuilder(widget.model.items));
  }

  Widget ItemPageBuilder(List<BannerItem>? listBanner) {
    if (listBanner != null && listBanner.length > 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
                pauseAutoPlayOnTouch: true),
            items: listBanner.map((e) {
              return Builder(
                builder: (BuildContext context) {
                  if (e.type == "IMAGE") {
                    return ItemImageBuilder(e);
                  } else {
                    return ItemVideoBuilder(e);
                  }
                },
              );
            }).toList(),
          ));
    } else {
      return Container();
    }
  }

  Widget ItemImageBuilder(BannerItem itemBanner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: itemBanner.path ?? "",
          placeholder: (context, url) => Container(),
          errorWidget: (context, url, error) => Image.asset(
            moke_image2,
          ),
        ),
      ),
    );
  }

  Widget ItemVideoBuilder(BannerItem itemBanner) {
    return GestureDetector(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(moke_image4))),
              ),
              new Align(
                alignment: Alignment.center,
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: transparent,
                        border: Border.all(color: white, width: 1)),
                    child: GestureDetector(
                      onTap: () {
                        changeScreen(
                            context,
                            BannerVideoPlayer(
                                videoUrl: itemBanner.path ?? "", thumbUrl: ""));
                      },
                      child: Icon(Icons.play_arrow_rounded),
                    )),
              )
            ],
          ),
        ),
        onTap: () {});
  }
}
