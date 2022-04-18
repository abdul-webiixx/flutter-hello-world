import 'package:Zenith/screen/my_class.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/utils/video_player_preview.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/instructor_home.dart';
import 'package:Zenith/model/instructor_profile.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/screen/start_meeting.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/widget/item_instructor_profile.dart';
import 'package:Zenith/widget/item_instructor_review.dart';
import 'package:Zenith/widget/item_instructor_upcoming.dart';
import 'oops.dart';

class InstructorHomeScreen extends StatefulWidget {
  InstructorHomeScreen({Key? key}) : super(key: key);
  @override
  _InstructorHomeScreenState createState() => _InstructorHomeScreenState();
}

class _InstructorHomeScreenState extends State<InstructorHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    new Tab(
      child: new Container(
        width: 100.0,
        child: new Tab(
          text: "Today",
        ),
      ),
    ),
    new Tab(
        child: new Container(
      width: 100.0,
      child: new Tab(
        text: 'Upcoming',
      ),
    )),
    new Tab(
        child: new Container(
      width: 100.0,
      child: new Tab(text: 'Workshop'),
    )),
    new Tab(
        child: new Container(
      width: 100.0,
      child: new Tab(text: 'Reviews'),
    )),
  ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = new TabController(vsync: this, length: myTabs.length);
    AppViewModel.initializer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
        authRequired: true,
        onModelReady: (model, userId, userType) {
          model.setUserId(userId);
          model.getInstructorHome(userId: userId ?? 0);
        },
        builder: (context, model, child) {
          return Scaffold(
              appBar: BaseAppBar(
                title: "Instructor Profile",
                isSuffixIcon: false,
                suffixIcon: PopupMenuButton(
                  onSelected: _select,
                  padding: EdgeInsets.zero,
                  icon: Container(
                    height: 30,
                    width: 30,
                    color: Theme.of(context).highlightColor,
                    child: Icon(
                      CustomIcons.menu,
                      size: 8,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                              child: Icon(
                                CustomIcons.user,
                                size: 18,
                              ),
                            ),
                            Text(
                              'Attendance',
                              style: styleProvider(),
                            )
                          ],
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                              child: Icon(
                                CustomIcons.logout,
                                size: 20,
                              ),
                            ),
                            Text(
                              'Sign Out',
                              style: styleProvider(),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              body: _buildUi(model));
        });
  }

  void _select(int choice) {
    switch (choice) {
      case 1:
        changeScreen(context, MyClassScreen());
        break;
      case 2:
        signOutDialog(context);
        break;
      default:
        break;
    }
  }

  Widget _buildUi(AppViewModel provider) {
    if (provider.instructorHomeModel.success != null &&
        provider.instructorHomeModel.success &&
        provider.instructorHomeModel.requestStatus == RequestStatus.loaded) {
      return _uiBuilder(model: provider.instructorHomeModel.instructorData!);
    } else if (provider.instructorHomeModel.requestStatus ==
        RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.InstructorHome);
    } else {
      return SomethingWentWrong(
        status: getResponse(provider.instructorHomeModel.requestStatus),
        message:
            provider.instructorHomeModel.requestStatus == RequestStatus.failure
                ? provider.failure.message
                : null,
      );
    }
  }

  Widget _uiBuilder({required InstructorData model}) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ItemInstructorProfile(model: model.profileData!),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 280,
            child: new DefaultTabController(
                length: myTabs.length,
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Theme.of(context).backgroundColor,
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    elevation: 0,
                    bottom: new PreferredSize(
                      preferredSize: new Size(50.0, 0.0),
                      child: Container(
                        child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            labelColor: Theme.of(context).primaryColorLight,
                            unselectedLabelStyle: styleProvider(
                                color: Theme.of(context).primaryColorLight,
                                size: 10),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: styleProvider(
                                size: 12,
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
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child:
                        new TabBarView(controller: _tabController, children: [
                      _listTodayClass(
                          list: model.todayLiveClasses,
                          instructor: model.profileData,
                          zoom: model.zoom),
                      _listUpcomingClass(list: model.upcomingLiveClasses),
                      _listWorkshop(
                          list: model.workshopClass,
                          instructor: model.profileData,
                          zoom: model.zoom),
                      _listReview(list: model.reviews)
                    ]),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget _listWorkshop(
      {required List<UpcomingModel>? list,
      Instructor? instructor,
      Zoom? zoom}) {
    if (list != null && list.length > 0) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: _listClassBuilder(list, instructor, zoom));
    } else {
      return DataNotFound(
        userType: UserType.Trainer,
        title: "No Class Assigned",
        subTitle: "",
        noIcon: true,
      );
    }
  }

  Widget _listTodayClass(
      {required List<UpcomingModel>? list,
      Instructor? instructor,
      Zoom? zoom}) {
    if (list != null && list.length > 0) {
      // print("!!!!!!!!!!!!!!!!!!!!!!!!");
      // print(list.length);
      // print("!!!!!!!!!!!!!!!!!!!!!!!!");
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: _listClassBuilder(list, instructor, zoom));
    } else {
      return DataNotFound(
        userType: UserType.Trainer,
        title: "No Class Assigned",
        subTitle: "",
        noIcon: true,
      );
    }
  }

  Widget _listUpcomingClass({required List<UpcomingModel>? list}) {
    if (list != null && list.length > 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: _listClassBuilder(list, null, null),
      );
    } else {
      return DataNotFound(
        userType: UserType.Trainer,
        title: "No Class Assigned",
        subTitle: "",
        noIcon: true,
      );
    }
  }

  Widget _listReview({required List<ReviewData>? list}) {
    if (list != null && list.length > 0) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: _listReviewBuilder(list),
      );
    } else {
      return DataNotFound(
        userType: UserType.Trainer,
        title: "No Review Available",
        subTitle: "",
        noIcon: true,
      );
    }
  }

  Widget _listClassBuilder(
      List<UpcomingModel> list, Instructor? instructor, Zoom? zoom) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return instructor != null
              ? GestureDetector(
                  onTap: () {
                    changeScreen(
                        context,
                        StartMeetingWidget(
                            zoom: zoom!,
                            instructor: instructor,
                            model: list[index]));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ItemInstructorUpcoming(model: list[index]),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ItemInstructorUpcoming(model: list[index]),
                );
        });
  }

  Widget _listReviewBuilder(List<ReviewData> list) {
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
                  child: ItemInstructorReview(
                    model: list[index],
                  )),
            ),
        itemCount: list.length,
        options: animOption);
  }
}
