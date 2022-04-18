import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Zenith/screen/main.dart';

class MessageBean {
  MessageBean({required this.itemId});
  final String itemId;

  late StreamController<MessageBean> _controller =
   StreamController<MessageBean>.broadcast();
  Stream<MessageBean> get onChanged => _controller.stream;

  late String _status;
  String get status => _status;
  set status(String value) {
    _status = value;
    _controller.add(this);
  }

  static final Map<String, Route<void>> routes = <String, Route<void>>{};
  Route<void> get route {
    final String routeName = '/detail/$itemId';
    if (itemId == "1") {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => MainScreen(
            currentTab: 0,
          ),
        ),
      );
    } else if (itemId == "2") {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => MainScreen(
            currentTab: 1,
          ),
        ),
      );
    } else if (itemId == "3") {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => MainScreen(
            currentTab: 2,
          ),
        ),
      );
    } else if (itemId == "4") {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => MainScreen(
            currentTab: 2,
          ),
        ),
      );
    } else if (itemId == "5") {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) =>MainScreen(
            currentTab: 2,
          ),
        ),
      );
    } else if (itemId == "6") {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => MainScreen(
            currentTab: 2,
          ),
        ),
      );
    } else {
      return routes.putIfAbsent(
        routeName,
            () => MaterialPageRoute<void>(
          settings: RouteSettings(name: routeName),
          builder: (BuildContext context) => MainScreen(
            currentTab: 2,
          ),
        ),
      );
    }
  }
}