import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/class_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/class.dart';
import 'package:Zenith/screen/offline_service.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/service.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_class.dart';
import 'shimmer.dart';

class ClassScreen extends StatefulWidget {
  @override
  _ClassScreenState createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      model.getClassData();
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: BaseAppBar(
          title: "Live Classes",
        ),
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          color: Theme.of(context).backgroundColor,
          child: _listClassProvider(model),
        ),
      );
    });
  }

  Widget _listClassProvider(ClassViewModel provider) {
    if (provider.classModel.success != null &&
        provider.classModel.success &&
        provider.classModel.requestStatus == RequestStatus.loaded) {
      return _listClass(provider,
          list: provider.classModel.classPage!.singleClass);
    } else if (provider.classModel.requestStatus == RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.CourseScreen);
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.classModel.requestStatus));
    }
  }

  Widget _listClass(ClassViewModel model, {required List<SingleClass>? list}) {
    if (list != null && list.length > 0) {
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
                      model.setClassId(classId: list[index].id!);
                      if (list[index].id == 2) {
                        changeScreen(context, OfflineServiceScreen());
                      } else {
                        changeScreen(
                            context,
                            ServiceScreen(
                              isOffline: false,
                            ));
                      }
                    },
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: ItemClasses(
                      model: list[index],
                    ),
                  ),
                ),
              ),
          itemCount: list.length,
          options: animOption);
    } else {
      return DataNotFound();
    }
  }
}
