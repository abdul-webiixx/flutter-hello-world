import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/screen/livestream.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_upcoming_live_screen.dart';

class UpcomingLiveClasses extends StatefulWidget {
  final int userId;
  final bool isLive;
  UpcomingLiveClasses({Key? key,required this.userId , required this.isLive}) : super(key: key);

  @override
  _UpcomingLiveClassesState createState() => _UpcomingLiveClassesState();
}

class _UpcomingLiveClassesState extends State<UpcomingLiveClasses> {

  late FirebaseService _firebaseService;
  @override
  void initState() {
    _firebaseService = new FirebaseService();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(
        onModelReady: (model, userId, userType){
          if(widget.isLive){
            model.getUpcomingLiveClasses(userId: widget.userId).then((value) => null)
                .onError((error, stackTrace) => _firebaseService.firebaseJsonError(apiCall: "getUpcomingLineClass",
                message: error.toString(), stackTrace: stackTrace, userId: widget.userId));
          }else{
            model.getUpcomingDemoClasses(userId: widget.userId).then((value) => null)
                .onError((error, stackTrace) => _firebaseService.firebaseJsonError(apiCall: "getUpcomingDemoClasses",
                message: error.toString(), stackTrace: stackTrace, userId: widget.userId));
          }
        },
        builder: (context, model, child){
      return Scaffold(
        appBar: BaseAppBar(title:widget.isLive ? "Upcoming Live Classes" :
        "Upcoming Demo Classes" , isLeading: true,),
        body: _screenBuilder(model),
      );
    });
  }

  Widget _screenBuilder(ClassViewModel provider){
    if(provider.upcomingLiveClassesModel.success!=null && provider.upcomingLiveClassesModel.success
        && provider.upcomingLiveClassesModel.requestStatus == RequestStatus.loaded){
      return _listProvider(list: provider.upcomingLiveClassesModel.upcomingModel!);
    }else if(provider.upcomingLiveClassesModel.requestStatus == RequestStatus.loading){
      return LoadingProgress();
    }else{
      return SomethingWentWrong(status: getResponse(provider.upcomingLiveClassesModel.requestStatus));
    }
  }

  Widget _listProvider({required List<UpcomingModel>? list}){
    if(list!=null && list.length>0){
      return _listBuilder(list: list);
    }else{
      return DataNotFound();
    }
  }

  Widget _listBuilder({required List<UpcomingModel> list}){
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return MaterialButton(
            onPressed: (){
              changeScreen(context, LiveStreamingScreen(userId: widget.userId, packageId: list[index].packageId!,
                isLive: true,));
            },
            child: ItemUpcomingLiveScreen(model: list[index],),);
        });
  }
}
