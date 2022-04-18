import 'dart:async';
import 'dart:io';

import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/instructor_home.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:custom_zoom_sdk/custom_zoom_options.dart';
import 'package:custom_zoom_sdk/custom_zoom_view.dart';
import 'package:flutter/material.dart';

class StartMeetingWidget extends StatefulWidget {
  final Zoom zoom;
  final UpcomingModel model;
  final Instructor instructor;
  StartMeetingWidget(
      {Key? key,
      required this.zoom,
      required this.model,
      required this.instructor})
      : super(key: key);

  @override
  _StartMeetingWidgetState createState() => _StartMeetingWidgetState();
}

class _StartMeetingWidgetState extends State<StartMeetingWidget> {
  late ZoomInitilaizedWithToken zoomOptions;
  late CustomZoomMeetingOptions meetingOptions;

  late Timer timer;

  bool _isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" ||
          status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }

  bool _isLoading = true;

  @override
  void initState() {
    this.zoomOptions = new ZoomInitilaizedWithToken(
        domain: zoom_domain, jwtToken: widget.zoom.jwtToken);
    this.meetingOptions = new CustomZoomMeetingOptions(
        userId: widget.model.hostId!,
        meetingId: widget.model.meetingId,
        zoomToken: widget.zoom.userToken,
        displayName: widget.instructor.name,
        zoomAccessToken: widget.zoom.accessToken,
        disableDialIn: "true",
        disableDrive: "true",
        disableInvite: "true",
        disableShare: "true",
        noAudio: "false",
        noDisconnectAudio: "false");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
          title: "Loading Meeting",
        ),
        body: Container(
          color: black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              _isLoading
                  ? Container(
                      height: 200,
                      child: LoadingProgress(),
                    )
                  : Container(),
              Expanded(
                child: CustomZoomView(onViewCreated: (controller) {
                  print("Created the view");

                  controller
                      .zoomInitializedWithToken(zoomOptions)
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
                          .startMeeting(meetingOptions)
                          .then((loginResult) {
                        print("LoginResultBool :- " + loginResult.toString());
                        if (loginResult) {
                          print("LoginResult :- Logged In");
                          setState(() {
                            _isLoading = false;
                          });
                        } else {
                          print("LoginResult :- Logged In Failed");
                        }
                      });
                    }
                  }).catchError((error) {
                    print(error);
                  });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
