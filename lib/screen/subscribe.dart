import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_current_subscription.dart';
import 'package:Zenith/widget/item_past_subscription.dart';

class SubscribeScreen extends StatefulWidget {
  final int userId;
  SubscribeScreen({Key? key, required this.userId}) : super(key: key);
  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

class _SubscribeScreenState extends State<SubscribeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    new Tab(
      child: new Container(
        width: 150.0,
        child: new Tab(
          text: 'Current',
        ),
      ),
    ),
    new Tab(
        child: new Container(
      width: 150.0,
      child: new Tab(text: 'Past'),
    )),
  ];
  late bool loader;
  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: myTabs.length);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Scaffold(
          appBar: BaseAppBar(
            title: "Subscriptions",
            isLeading: true,
          ),
          body: new DefaultTabController(
              length: 3,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Theme.of(context).backgroundColor,
                appBar: AppBar(
                  backgroundColor: Theme.of(context).backgroundColor,
                  elevation: 0,
                  bottom: new PreferredSize(
                    preferredSize: new Size(200.0, 0.0),
                    child: Container(
                      child: TabBar(
                          controller: _tabController,
                          labelColor: Theme.of(context).primaryColorLight,
                          unselectedLabelStyle: styleProvider(
                              color: Theme.of(context).primaryColorLight),
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: styleProvider(
                              size: 16,
                              fontWeight: medium,
                              color: Theme.of(context).primaryColorLight),
                          indicator: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 2.0,
                          ))),
                          tabs: myTabs),
                    ),
                  ),
                ),
                body: Container(
                  color: Theme.of(context).backgroundColor,
                  child: new TabBarView(controller: _tabController, children: [
                    ItemCurrentSubscription(
                      userId: widget.userId,
                    ),
                    ItemPastSubscription(
                      userId: widget.userId,
                    ),
                  ]),
                ),
              ))),
    );
  }
}
