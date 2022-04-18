import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/utils/orientation/landscape_player_page.dart';

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final bool isFullScreen;
  final String? thumbUrl;
  const BasicOverlayWidget(
      {Key? key,
      required this.controller,
      required this.isFullScreen,
      required this.thumbUrl})
      : super(key: key);

  @override
  _BasicOverlayWidgetState createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {
  bool inControls = true;
  bool inThumb = true;
  @override
  void initState() {
    inThumb = true;
    super.initState();
  }

  Widget buildIndicator() => !inControls
      ? Container()
      : Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(color: btBackground),
          child: VideoProgressIndicator(
            widget.controller,
            allowScrubbing: true,
            colors: new VideoProgressColors(
                backgroundColor: Colors.grey[300]!,
                bufferedColor: Colors.grey[600]!,
                playedColor: primaryColor),
          ),
        );

  Widget buildPlay() => !inControls
      ? Container()
      : GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
              inThumb = false;
            });
          },
          child: Container(
            alignment: Alignment.center,
            child: Icon(
                widget.controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
                size: 40),
          ),
        );

  Widget buildThumb() => !inThumb
      ? Container()
      : widget.thumbUrl != null
          ? Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: highlightColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.thumbUrl != null ? widget.thumbUrl! : "",
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Image.asset(
                  moke_image3,
                  fit: BoxFit.fill,
                ),
              ),
            )
          : Container();

  @override
  Widget build(BuildContext context) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            inControls = !inControls;
          });
        },
        child: Stack(
          children: <Widget>[
            buildThumb(),
            buildPlay(),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: buildIndicator(),
            ),
            Positioned(
                bottom: 20,
                right: 20,
                child: Row(
                  children: [
                    volumeChanger(),
                    SizedBox(
                      width: 10,
                    ),
                    orientationChanger(),
                  ],
                )),
            Positioned(
                bottom: 0,
                top: 0,
                left: 100,
                child: new Align(
                  alignment: Alignment.center,
                  child: backForward(),
                )),
            Positioned(
                bottom: 0,
                top: 0,
                right: 100,
                child: new Align(
                  alignment: Alignment.center,
                  child: fastForward(),
                )),
          ],
        ),
      );

  Widget orientationChanger() => !inControls
      ? Container()
      : GestureDetector(
          onTap: () async {
            if (widget.isFullScreen) {
              await setPortrait();
              backToScreen(context);
            } else {
              changeScreen(
                  context,
                  LandscapePlayerPage(
                    controller: widget.controller,
                    thumbUrl: widget.thumbUrl,
                  ));
            }
          },
          child: Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: btBackground,
              ),
              child: Icon(
                widget.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                size: 15,
              )),
        );

  Future setPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Wakelock.enabled;
  }

  Widget volumeChanger() => !inControls
      ? Container()
      : GestureDetector(
          onTap: () {
            if (widget.controller.value.volume == 0) {
              widget.controller.setVolume(0.5);
            } else {
              widget.controller.setVolume(0.0);
            }
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: btBackground,
            ),
            child: Icon(
              widget.controller.value.volume > 0
                  ? Icons.volume_up
                  : Icons.volume_off,
              color: Colors.white,
              size: 15,
            ),
          ));

  Widget backForward() => !inControls
      ? Container()
      : Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: btBackground),
          child: GestureDetector(
            onTap: () {
              int adds = widget.controller.value.position.inSeconds - 10;
              widget.controller.seekTo(Duration(seconds: adds));
            },
            child: Icon(
              Icons.arrow_back_ios_outlined,
              size: 20,
            ),
          ));

  Widget fastForward() => !inControls
      ? Container()
      : Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: btBackground),
          child: GestureDetector(
            onTap: () {
              int adds = widget.controller.value.position.inSeconds + 10;
              widget.controller.seekTo(Duration(seconds: adds));
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: 20,
            ),
          ));
}
