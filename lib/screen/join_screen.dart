import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'join_meeting.dart';

class JoinWidget extends StatefulWidget {
  JoinWidget({Key? key}) : super(key: key);
  @override
  _JoinWidgetState createState() => _JoinWidgetState();
}

class _JoinWidgetState extends State<JoinWidget> {

  late TextEditingController meetingIdController ;
  late TextEditingController meetingPasswordController;
  @override
  void initState() {
    meetingIdController = TextEditingController();
    meetingPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // new page needs scaffolding!
    return Container(
      color: black,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
        appBar: BaseAppBar(title: "Start Meeting", isLeading: true,),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                      controller: meetingIdController,
                      decoration: InputDecoration(
                        labelText: 'Meeting ID',
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                      controller: meetingPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Meeting Password',
                      )),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Builder(
                    builder: (context) {
                      return CustomButton(onPressed: (){

                        // joinMeeting(context);
                      }, title: "Start Meeting");
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  // joinMeeting(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) {
  //         return MeetingWidget(meetingId: meetingIdController.text, meetingPassword: meetingPasswordController.text);
  //       },
  //     ),
  //   );
  // }


}