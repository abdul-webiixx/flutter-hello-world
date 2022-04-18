import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/service_package.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_service_package.dart';

import 'days.dart';

class NestedServicePackage extends StatefulWidget {
  final BatchData batchData;
  final int classId;
  NestedServicePackage(
      {Key? key, required this.batchData, required this.classId})
      : super(key: key);
  @override
  _NestedServicePackageState createState() => _NestedServicePackageState();
}

class _NestedServicePackageState extends State<NestedServicePackage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    CartViewModel.initializer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [];
    for (int i = 0; i < widget.batchData.dayList!.length; i++) {
      tabs.add(new Tab(
        child: new Container(
          width: 80.0,
          child: new Tab(
            text: widget.batchData.dayList![i].dayName,
          ),
        ),
      ));
    }
    _tabController = new TabController(
        vsync: this, length: widget.batchData.dayList!.length);
    return new DefaultTabController(
        length: widget.batchData.dayList!.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: new Size(40.0, 40.0),
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    child: TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).backgroundColor,
                        unselectedLabelStyle: styleProvider(
                            color: Theme.of(context).primaryColor),
                        unselectedLabelColor: white,
                        labelStyle: styleProvider(
                            size: 12,
                            fontWeight: medium,
                            color: Theme.of(context).backgroundColor),
                        indicator: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        tabs: tabs),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
            color: Theme.of(context).backgroundColor,
            child: new TabBarView(
                controller: _tabController,
                children: _listWidget(dayList: widget.batchData.dayList!)),
          ),
        ));
  }

  List<Widget> _listWidget({required List<DayList> dayList}) {
    List<Widget> _tabList = [];
    for (int i = 0; i < dayList.length; i++) {
      _tabList.add(batchWidget(dayList: dayList[i]));
    }
    return _tabList;
  }

  Widget batchWidget({required DayList dayList}) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
      child: _listPackages(list: dayList.monthList!),
    );
  }

  Widget _listPackages({required List<MonthList> list}) {
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
                    getUserId().then((value) {
                      if (value != null) {
                        changeScreen(
                            context,
                            DaysScreen(
                                productId: list[index].packageId!,
                                productType: list[index].productType!,
                                price: list[index].totalCost!,
                                classId: widget.classId,
                                days: list[index].days ?? 7));
                      }
                    });
                  },
                  padding: EdgeInsets.symmetric(vertical: 3),
                  child: ItemServicePackage(model: list[index]),
                ),
              ),
            ),
        itemCount: list.length,
        options: animOption);
  }
}
