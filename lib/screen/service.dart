import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/class_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/screen/offline_service_type.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/service_type.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_class.dart';

class ServiceScreen extends StatefulWidget {
  final bool isOffline;
  ServiceScreen({Key? key, required this.isOffline}) : super(key: key);
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      if (widget.isOffline) {
        model.getOfflineServiceData();
      } else {
        model.getServiceData();
      }
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(title: "Type", isLeading: true),
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).backgroundColor,
          child: _listClassProvider(model),
        ),
      );
    });
  }

  Widget _listClassProvider(ClassViewModel provider) {
    if (provider.serviceModel.success != null &&
        provider.serviceModel.success &&
        provider.serviceModel.requestStatus == RequestStatus.loaded) {
      return _listService(
          list: provider.serviceModel.classPage!.singleClass!,
          classId: provider.classId);
    } else if (provider.serviceModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.serviceModel.requestStatus));
    }
  }

  Widget _listService({required List<SingleClass> list, required int classId}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return MaterialButton(
            onPressed: () {
              if (list[index].type == "Diploma") {
                changeScreen(
                    context,
                    OfflineServiceTypeScreen(
                      classId: classId,
                      title: list[index].name,
                      serviceId: list[index].id!,
                      type: list[index].type!,
                    ));
              } else {
                changeScreen(
                    context,
                    ServiceTypeScreen(
                        serviceId: list[index].id!, form: list[index].name));
              }
            },
            padding: EdgeInsets.symmetric(vertical: 3),
            child: ItemClasses(
              model: list[index],
            ),
          );
        });
  }
}
