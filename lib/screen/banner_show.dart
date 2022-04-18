import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/screen/video.dart';

import 'package:flutter/material.dart';

class BannerVideoPlayer extends StatefulWidget {
  final String? videoUrl;
  final String? thumbUrl;
  const BannerVideoPlayer({Key? key, this.videoUrl, this.thumbUrl})
      : super(key: key);

  @override
  _BannerVideoPlayerState createState() => _BannerVideoPlayerState();
}

class _BannerVideoPlayerState extends State<BannerVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(isLeading: true),
        body: Container(
          child: Center(
            child: VideoPlayerScreen(
              videoUrl: widget.videoUrl ?? "",
              thumbUrl: widget.thumbUrl ?? video_thumb_url,
            ),
          ),
        ),
      ),
    );
  }
}
