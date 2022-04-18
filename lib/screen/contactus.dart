import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/screen/support.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_class.dart';

class ContactUsScreen extends StatefulWidget {
  final UserInformation? model;
  ContactUsScreen({Key? key, required this.model}) : super(key: key);
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  List<SingleClass> _listSupports = [
    new SingleClass(
        id: 0,
        description: "live chatting with our support team",
        name: "Chat with us",
        avatar:
            "https://Zenithdance-images.s3.ap-south-1.amazonaws.com/settings/August2021/1RNM9zC26QQBR6HNnSMF.png"),
    new SingleClass(
        id: 1,
        description: "live calling with our support team",
        name: "Call us",
        avatar:
            "https://Zenithdance-images.s3.ap-south-1.amazonaws.com/settings/August2021/5qtk5RHXZ2cNVhoUJqub.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            color: Theme.of(context).backgroundColor,
            child: _listContact(list: _listSupports)),
      ),
    );
  }

  Widget _listContact({required List<SingleClass> list}) {
    return LiveList.options(
        scrollDirection: Axis.vertical,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) =>
            FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              // And slide transition
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -0.1),
                  end: Offset.zero,
                ).animate(animation),
                // Paste you Widget
                child: MaterialButton(
                  onPressed: () {
                    if (index == 0) {
                      changeScreen(
                          context,
                          SupportScreen(
                              userName: widget.model!.name!,
                              userEmail: widget.model!.email!));
                    } else {
                      showToast(context,
                          msg: "This service currently not available");
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: ItemClasses(
                    model: list[index],
                    isStatic: true,
                  ),
                ),
              ),
            ),
        itemCount: list.length,
        options: animOption);
  }
}
