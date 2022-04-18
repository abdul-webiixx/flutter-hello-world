import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemLiveStreaming extends StatefulWidget {
  const ItemLiveStreaming({Key? key}) : super(key: key);
  @override
  _ItemLiveStreaming createState() => _ItemLiveStreaming();
}

class _ItemLiveStreaming extends State<ItemLiveStreaming> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "ic_vplay",
                          height: 60,
                          width: 60,
                        )),
                    // ControlsOverlays(controller: _videoPlayerController),
                  ],
                ),
              )),
          Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: new Align(
                  child: Container(
                    width: 150,
                    height: 50,
                    margin: EdgeInsets.only(right: 30),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [amber_800!, amber]),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Jazz Dance",
                          style: styleProvider(
                              color: Theme.of(context).backgroundColor,
                              fontWeight: bold),
                        ),
                        Text(
                          "01:45 pm - 02:45 pm",
                          style: styleProvider(
                              color: Theme.of(context).backgroundColor,
                              fontWeight: regular,
                              size: 10),
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 20,
              right: 0,
              child: new Align(
                alignment: Alignment.topRight,
                child: Center(
                  child: Container(
                    width: 65,
                    height: 20,
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [amber_800!, amber_600!]),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    child: Center(
                        child: Text(
                      "Live Now",
                      style: styleProvider(
                          color: Theme.of(context).backgroundColor,
                          fontWeight: semiBold,
                          size: 12),
                    )),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
