import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/my_class.dart';
import 'package:Zenith/screen/attendance.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/widget/item_my_class.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'oops.dart';

class MyClassScreen extends StatefulWidget {
  const MyClassScreen({Key? key}) : super(key: key);

  @override
  _MyClassScreenState createState() => _MyClassScreenState();
}

class _MyClassScreenState extends State<MyClassScreen> {

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(
      authRequired: true,
        onModelReady: (model, userId, userType){
          model.getMyClass(userId: userId ?? 0);
        },
        builder: (context, model, child){
          return Scaffold(
              appBar: BaseAppBar(isLeading: true, title: "My Class",),
              body: Container(
                child: _listClassProvider(model),
              )
          );
        });
  }

  Widget _listClassProvider(ClassViewModel provider){
    if(provider.myClassModel.success!=null && provider.myClassModel.success){
      return _listClassBuilder(classModel: provider.myClassModel);
    }else if(provider.myClassModel.requestStatus == RequestStatus.loading){
      return Shimmer(shimmerFor: ShimmerFor.Choreography);
    }else{
      return SomethingWentWrong(status: getResponse(provider.classModel.requestStatus));
    }
  }

  Widget _listClassBuilder({required MyClassModel classModel}){
    if(classModel.myClassData !=null && classModel.myClassData!.length>0){
      return _listClasses(listClass: classModel.myClassData!);
    }else {
      return DataNotFound();
    }
  }

  Widget _listClasses({required List<MyClassData> listClass}) {
    return LiveList.options(
        scrollDirection: Axis.vertical,
        itemBuilder: ( BuildContext context,
            int index,
            Animation<double> animation,)=> FadeTransition(
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
              child: InkWell(
                onTap: (){
                 changeScreen(context, AttendanceScreen(classId: listClass[index].id!,));
                },
                child: ItemMyClass(model: listClass[index],),
              )
          ),
        ), itemCount: listClass.length, options: animOption);
  }
}
