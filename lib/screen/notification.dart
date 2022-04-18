import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/app_view_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/notification.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_notification.dart';

import 'oops.dart';

class NotificationScreen extends StatefulWidget {
  final bool? isBack;
  NotificationScreen({Key? key, this.isBack}) : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late FirebaseService _firebaseService;

  List<NotificationDetails> tempNotification = [
    new NotificationDetails(
        id: 1,
        createdAt: DateTime.now(),
        description: "Welcome to our app, This is a welcome massage"),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
        onModelReady: (model, userId, userType) async {
      _firebaseService = new FirebaseService();
      await model
          .getNotification(userId: await userId ?? 0)
          .then((value) => null)
          .onError((error, stackTrace) => _firebaseService.firebaseJsonError(
              apiCall: "fetchNotification",
              message: error.toString(),
              userId: userId));
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(
          title: "Notifications",
          isLeading:
              widget.isBack != null && widget.isBack! ? widget.isBack : false,
        ),
        body: _notificationBuilder(model),
      );
    });
  }

  Widget _notificationBuilder(AppViewModel provider) {
    if (provider.notificationModel.success != null &&
        provider.notificationModel.success &&
        provider.notificationModel.requestStatus == RequestStatus.loaded) {
      return _listProvider(model: provider.notificationModel.notificationData);
    } else if (provider.notificationModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.notificationModel.requestStatus),
        message:
            provider.notificationModel.requestStatus == RequestStatus.failure
                ? provider.failure.message
                : null,
      );
    }
  }

  Widget _listProvider({required NotificationData? model}) {
    if (model != null) {
      return model.notificationDetails != null &&
              model.notificationDetails!.length > 0
          ? _listBuilder(list: model.notificationDetails!)
          : _listBuilder(list: tempNotification);
    } else {
      return DataNotFound();
    }
  }

  Widget _listBuilder({required List<NotificationDetails> list}) {
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
                    onPressed: () {},
                    splashColor: transparent,
                    padding: EdgeInsets.only(top: 10),
                    child: ItemNotification(
                      model: list[index],
                    ),
                  )),
            ),
        itemCount: list.length,
        options: animOption);
  }
}
