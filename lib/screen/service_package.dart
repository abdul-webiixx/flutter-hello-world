import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/class_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/service_package.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'nested_service_package.dart';
import 'oops.dart';

class ServicePackage extends StatefulWidget {
  final int serviceTypeId;
  final int classId;
  final int serviceId;
  final String form;
  ServicePackage(
      {Key? key,
      required this.serviceTypeId,
      required this.classId,
      required this.serviceId,
      required this.form})
      : super(key: key);
  @override
  _ServicePackageState createState() => _ServicePackageState();
}

class _ServicePackageState extends State<ServicePackage>
    with TickerProviderStateMixin {
  late TabController? _tabController;

  @override
  void dispose() {
    if (_tabController != null) {
      _tabController!.dispose();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 0);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      model.getServicePackage(
          serviceId: widget.serviceId,
          serviceTypeId: widget.serviceTypeId,
          classId: widget.classId);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          title: widget.form,
          isLeading: true,
        ),
        body: _screenProvider(model),
      );
    });
  }

  Widget _screenProvider(ClassViewModel provider) {
    if (provider.servicePackage.success != null &&
        provider.servicePackage.success &&
        provider.servicePackage.requestStatus == RequestStatus.loaded) {
      return _tabScreen(batchData: provider.servicePackage.batchData!);
    } else if (provider.servicePackage.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else if (provider.servicePackage.requestStatus == RequestStatus.failure) {
      return SomethingWentWrong(
          status: getResponse(provider.servicePackage.requestStatus));
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.servicePackage.requestStatus));
    }
  }

  Widget _tabScreen({required List<BatchData> batchData}) {
    List<Tab> tabs = [];
    for (int i = 0; i < batchData.length; i++) {
      tabs.add(new Tab(
        child: new Container(
          width: 150.0,
          child: new Tab(
            text: batchData[i].batchName,
          ),
        ),
      ));
    }
    _tabController = new TabController(vsync: this, length: batchData.length);
    return new DefaultTabController(
        length: batchData.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: new PreferredSize(
            preferredSize: new Size(200.0, 50.0),
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).primaryColorLight,
                  unselectedLabelStyle:
                      styleProvider(color: Theme.of(context).primaryColorLight),
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
                  tabs: tabs),
            ),
          ),
          body: Container(
            color: Theme.of(context).backgroundColor,
            child: new TabBarView(
                controller: _tabController,
                children: _listWidget(batchList: batchData)),
          ),
        ));
  }

  List<Widget> _listWidget({required List<BatchData> batchList}) {
    List<Widget> _tabList = [];
    for (int i = 0; i < batchList.length; i++) {
      _tabList.add(NestedServicePackage(
        batchData: batchList[i],
        classId: widget.classId,
      ));
    }
    return _tabList;
  }
}
