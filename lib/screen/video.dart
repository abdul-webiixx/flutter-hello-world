import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:Zenith/utils/orientation/basic_overlay_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  String? videoUrl;
  String? thumbUrl;
  VideoPlayerScreen({Key? key, required this.videoUrl, required this.thumbUrl})
      : super(key: key);
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController controller;
  bool isFullScreen = false;
  @override
  void initState() {
    super.initState();
          controller = VideoPlayerController.network(widget.videoUrl!)
        ..addListener(() => setState(() {}))
        ..setLooping(false)
        ..initialize().then((_) => controller.pause());

    setPortrait();
  }

  @override
  void dispose() {
    setAllOrientations();
    controller.dispose();
    super.dispose();
  }

  Future setPortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Wakelock.enabled;
  }

  Future setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await Wakelock.disable();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
         VideoPlayer(controller),
          BasicOverlayWidget(
            controller: controller,
            isFullScreen: false,
            thumbUrl: widget.thumbUrl,
          )
        ],
      ),
    );
  }
}
