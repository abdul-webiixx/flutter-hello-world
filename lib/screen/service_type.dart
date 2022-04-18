import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/class_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/service_package.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_service_type.dart';

class ServiceTypeScreen extends StatefulWidget {
  final int serviceId;
  final String form;
  ServiceTypeScreen({Key? key, required this.serviceId, required this.form})
      : super(key: key);

  @override
  _ServiceTypeScreenState createState() => _ServiceTypeScreenState();
}

class _ServiceTypeScreenState extends State<ServiceTypeScreen> {
  Widget _listClassProvider(ClassViewModel provider) {
    if (provider.serviceTypeModel.success != null &&
        provider.serviceTypeModel.success &&
        provider.serviceTypeModel.requestStatus == RequestStatus.loaded) {
      return _listServiceType(
          list: provider.serviceTypeModel.classPage!.singleClass!,
          classId: provider.classId);
    } else if (provider.serviceTypeModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.serviceTypeModel.requestStatus));
    }
  }

  Widget _listServiceType(
      {required List<SingleClass> list, required int classId}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (300 / 328),
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                changeScreen(
                    context,
                    ServicePackage(
                      serviceTypeId: list[index].id!,
                      serviceId: list[index].serviceId!,
                      classId: classId,
                      form: list[index].name,
                    ));
              },
              child: ItemServiceType(
                model: list[index],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      model.getServiceTypeData(serviceId: widget.serviceId);
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(title: widget.form, isLeading: true),
        body: _listClassProvider(model),
      );
    });
  }
}
