import 'dart:async';
import 'dart:io';
import 'package:custom_zoom_sdk/custom_zoom_options.dart';
import 'package:custom_zoom_sdk/custom_zoom_view.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';

class MeetingWidget extends StatelessWidget {
  late ZoomInitilaizedWithOutToken zoomOptions;
  late CustomZoomMeetingOptions meetingOptions;

  late Timer timer;

  MeetingWidget({Key? key, meetingId, meetingPassword}) : super(key: key) {
    this.zoomOptions = new ZoomInitilaizedWithOutToken(
      domain: zoom_domain,
      appKey: zoom_app_key,
      appSecret: zoom_app_secret,
    );
    this.meetingOptions = new CustomZoomMeetingOptions(
        userId: 'Hi User', //pass username for join meeting only
        meetingId: meetingId, //pass meeting id for join meeting only
        meetingPassword:
            meetingPassword, //pass meeting password for join meeting only
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false");
  }

  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: black,
      child: Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
          title: "Live Screen",
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: CustomZoomView(onViewCreated: (controller) {
              print("Created the view");

              controller
                  .zoomInitializedWithOutToken(this.zoomOptions)
                  .then((results) {
                print("initialised");
                print(results);

                if (results[0] == 0) {
                  controller.zoomStatusEvents.listen((status) {
                    print("Meeting Status Stream: " +
                        status[0] +
                        " - " +
                        status[1]);
                    if (_isMeetingEnded(status[0])) {
                      Navigator.pop(context);
                      timer.cancel();
                    }
                  });

                  print("listen on event channel");

                  controller
                      .joinMeeting(this.meetingOptions)
                      .then((joinMeetingResult) {
                    timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                      controller
                          .meetingStatus(this.meetingOptions.meetingId!)
                          .then((status) {
                        print("Meeting Status Polling: " +
                            status[0] +
                            " - " +
                            status[1]);
                      });
                    });
                  });
                }
              }).catchError((error) {
                print("Error");
                print(error);
              });
            })),
      ),
    );
  }
}
