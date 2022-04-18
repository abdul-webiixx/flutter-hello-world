import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/provider/cartIcon.dart';
import 'package:Zenith/screen/all_instructor.dart';
import 'package:Zenith/screen/cart.dart';
import 'package:Zenith/screen/service.dart';
import 'package:Zenith/screen/shimmer.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/widget/item_home_banner.dart';
import 'package:Zenith/widget/item_home_dance_class.dart';
import 'package:Zenith/widget/item_home_workshop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/home.dart';
import 'package:Zenith/model/review.dart';
import 'package:Zenith/model/upcoming.dart';
import 'package:Zenith/screen/instructor_profile.dart';
import 'package:Zenith/screen/livestream.dart';
import 'package:Zenith/screen/main.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/review.dart';
import 'package:Zenith/screen/search.dart';
import 'package:Zenith/screen/upcoming.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_home_instructor.dart';
import 'package:Zenith/widget/item_home_upcoming_live_class.dart';
import 'package:Zenith/widget/item_review.dart';
import 'package:Zenith/widget/item_home_dance_course.dart';
import 'package:Zenith/widget/item_widget_drawer.dart';
import 'package:provider/provider.dart';
import 'join_meeting.dart';
import 'offline_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late FirebaseService _firebaseService;
  // CartService _cartService = CartService();
  late CartViewModel _cartViewModel;
  @override
  void initState() {
    AppViewModel.initializer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _homeUiBuilder({required AppViewModel model, required int? userId}) {
    if (model.homeModel.success != null && model.homeModel.success) {
      _appViewModel = MProvider.timeOffBlocOf(context);
      _appViewModel.getCartItemsCouunt();
      _cartViewModel = Provider.of<CartViewModel>(context, listen: false);

      return _homeUi(userId: model.userId, model: model.homeModel.homeData!);
    } else if (model.homeModel.requestStatus == RequestStatus.loading) {
      return Shimmer(shimmerFor: ShimmerFor.Home);
    } else {
      return SomethingWentWrong(
        status: getResponse(model.homeModel.requestStatus),
        message: model.homeModel.requestStatus == RequestStatus.failure
            ? model.failure.message
            : network_error,
      );
    }
  }

  Widget _homeUi({required HomeData model, required int? userId}) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                changeScreen(context, SearchScreen());
              },
              child: Container(
                  height: 36,
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CustomIcons.search,
                        size: 13,
                        color: grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search",
                        style: styleProvider(size: 12, color: grey),
                      )
                    ],
                  )),
            ),
            model.banner != null && model.banner!.length > 0
                ? _bannerClass(model.banner)
                : Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(moke_image4))),
                          ),
                          new Align(
                            alignment: Alignment.center,
                            child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: transparent,
                                    border: Border.all(color: white, width: 1)),
                                child: GestureDetector(
                                  onTap: () {
                                    // changeScreen(context, JoinWidget());
                                  },
                                  child: Icon(Icons.play_arrow_rounded),
                                )),
                          )
                        ],
                      ),
                    )),
            model.danceCourses != null && model.danceCourses!.length > 0
                ? _danceCourse(model: model.danceCourses!)
                : Container(),
            model.danceClasses != null && model.danceClasses!.length > 0
                ? _danceClass(model: model.danceClasses!)
                : Container(),
            model.workshop != null || model.listWorkshop != null
                ? _workShopClass(
                    userId: userId,
                    model: model.workshop,
                    listModel: model.listWorkshop)
                : Container(),
            model.instructors != null && model.instructors!.length > 0
                ? _instructor(model: model.instructors!)
                : Container(),
            model.upcomingLiveClasses != null &&
                    model.upcomingLiveClasses!.length > 0
                ? _upcomingLiveClass(
                    userId: userId,
                    model: sortUpcomingList(model.upcomingLiveClasses!),
                    isLive: true)
                : Container(),
            model.upcomingDemoClasses != null &&
                    model.upcomingDemoClasses!.length > 0
                ? _upcomingLiveClass(
                    userId: userId,
                    model: sortUpcomingList(model.upcomingDemoClasses!),
                    isLive: false)
                : Container(),
            model.reviews != null && model.reviews!.length > 0
                ? _review(model: model.reviews!)
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _bannerClass(List<BannerClass>? model) {
    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: model!.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemHomeBanner(model: model[index]);
            }));
  }

  List<UpcomingModel> sortUpcomingList(List<UpcomingModel> snapshot) {
    snapshot.sort((m, m2) => int.parse(m.date!).compareTo(int.parse(m2.date!)));
    return snapshot;
  }

  Widget _danceClass({required List<DanceClass> model}) {
    return BaseView<ClassViewModel>(
        fullScreen: true,
        builder: (context, provider, child) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Dance Classes", style: styleProvider()),
                    GestureDetector(
                      onTap: () {
                        changeScreen(context, MainScreen(currentTab: 2));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "View All",
                            style: styleProvider(size: 10.0, color: grey),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SvgPicture.asset(
                            ic_arrow,
                            width: 15,
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _classItem(list: model, provider: provider),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        });
  }

  Widget _workShopClass(
      {List<Workshop>? listModel, Workshop? model, required int? userId}) {
    return BaseView<ClassViewModel>(
        fullScreen: true,
        builder: (context, provider, child) {
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("WorkShop", style: styleProvider()),
                    listModel != null
                        ? GestureDetector(
                            onTap: () {
                              changeScreen(context, MainScreen(currentTab: 2));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "View All",
                                  style: styleProvider(size: 10.0, color: grey),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                  ic_arrow,
                                  width: 15,
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                _workshopItem(
                    listWorkshop: listModel,
                    workshop: model,
                    provider: provider,
                    userId: userId!),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        });
  }

  Widget _danceCourse({required List<DanceCourse> model}) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Dance Courses", style: styleProvider()),
              GestureDetector(
                onTap: () {
                  changeScreen(context, MainScreen(currentTab: 1));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "View All",
                      style: styleProvider(size: 10.0, color: grey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      ic_arrow,
                      width: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          _courseItem(list: model),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget _courseItem({List<DanceCourse>? list}) {
    if (list != null && list.length > 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          alignment: Alignment.centerLeft,
          child: LiveList.options(
              scrollDirection: Axis.horizontal,
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
                      child: GestureDetector(
                        onTap: () {
                          changeScreen(context, MainScreen(currentTab: 1));
                        },
                        child: ItemHomeDanceCourse(
                          model: list[index],
                        ),
                      ),
                    ),
                  ),
              itemCount: list.length,
              options: animOption));
    } else {
      return Container();
    }
  }

  Widget _classItem(
      {List<DanceClass>? list, required ClassViewModel provider}) {
    if (list != null && list.length > 0) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          alignment: Alignment.centerLeft,
          child: LiveList.options(
              scrollDirection: Axis.horizontal,
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
                      child: GestureDetector(
                        onTap: () {
                          provider.setClassId(classId: list[index].id!);
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
                        child: ItemHomeDanceClass(
                          model: list[index],
                        ),
                      ),
                    ),
                  ),
              itemCount: list.length,
              options: animOption));
    } else {
      return Container();
    }
  }

  Widget _workshopItem(
      {List<Workshop>? listWorkshop,
      Workshop? workshop,
      required int userId,
      required ClassViewModel provider}) {
    if (listWorkshop != null && listWorkshop.length > 0 && workshop == null) {
      return Container(
          width: MediaQuery.of(context).size.width,
          height: 180,
          alignment: Alignment.centerLeft,
          child: LiveList.options(
              scrollDirection: Axis.horizontal,
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
                      child: GestureDetector(
                        onTap: () {
                          // changeScreen(
                          //     context,
                          //     MeetingWidget(
                          //       meetingId: listWorkshop[index].meetingId,
                          //       meetingPassword: listWorkshop[index].password!,
                          //     ));
                          // changeScreen(
                          //     context, _workShopDetails(listWorkshop[index]));
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => _workShopDetails(
                                          listWorkshop[index], userId)))
                              .then((value) {
                            _appViewModel.cartItemCount;
                          });
                        },
                        child: ItemHomeWorkshopClass(
                          model: listWorkshop[index],
                        ),
                      ),
                    ),
                  ),
              itemCount: listWorkshop.length,
              options: animOption));
    } else if (listWorkshop == null && workshop != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            // changeScreen(
            //     context,
            //     MeetingWidget(
            //       meetingId: workshop.meetingId,
            //       meetingPassword: workshop.password!,
            //     ));
            changeScreen(context, _workShopDetails(workshop, userId));
          },
          child: ItemHomeWorkshopClass(
            model: workshop,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _workShopDetails(Workshop model, int userId) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: model.image ?? "",
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Image.asset(
                          ic_dance_girl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text("${model.name ?? "Workshop"}",
                        maxLines: 1,
                        style: styleProvider(
                            fontWeight: bold, color: white, size: 18)),
                    Text(
                      "${model.details ?? "A Form for dance you will learn"}",
                      maxLines: 10,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14.0,
                          fontWeight: regular,
                          color: grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Text(
                        "${"Date: " + dateFormatter(model.start_time!)}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: regular,
                            color: grey),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${"Start Time: " + timeFormatter(model.start_time!)}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: regular,
                            color: grey),
                      ),
                    ),
                    Container(
                      child: Text(
                        "${"End Time: " + timeFormatter(model.end_time!)}",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: regular,
                            color: grey),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Duration : ${model.duration.toString() + ' Minutes'} ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: regular,
                            color: grey),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Price: ${model.price} ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            fontWeight: regular,
                            color: Colors.yellow),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) {
                    return CustomButton(
                        onPressed: () async {
                          if (model.subscription == "Active") {
                            changeScreen(
                                context,
                                MeetingWidget(
                                  meetingId: model.meetingId,
                                  meetingPassword: model.password!,
                                ));

                            print("Subsciption Active");
                            print(model.subscription);
                            print(model.status);
                            print(userId);
                            print(model.id);
                          } else if (model.subscription == "Inactive") {
                            _cartViewModel
                                .getAddToCart(
                                    userId: userId,
                                    productId: model.id!,
                                    productType: model.productType!,
                                    price: model.price!,
                                    // days: "monday",
                                    quantity: 1)
                                .then((value) {
                              showToast(context, msg: value.message!);
                              if (value.success) {
                                changeScreen(context, CartScreen());
                                _appViewModel =
                                    MProvider.timeOffBlocOf(context);
                                _appViewModel.cartItemCount! - 1;
                                print(value.status);
                                print("Subsciption is emply");
                                print(model.subscription);
                                // print(model.status);
                              } else
                                print(value.status);
                            });
                          }
                          // else {
                          //   print("Else Condition run");
                          //   print(model.current_subscription!);
                          //   print(model.subscription);
                          //   print(model.service_name);
                          //     print(userId);
                          // }
                        },
                        title: "Join Now");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _instructor({required List<Instructor> model}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Instructors", style: styleProvider()),
              GestureDetector(
                onTap: () {
                  changeScreen(context, AllInstructorScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "View All",
                      style: styleProvider(size: 10.0, color: grey),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      ic_arrow,
                      width: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 200,
              alignment: Alignment.centerLeft,
              child: LiveList.options(
                  scrollDirection: Axis.horizontal,
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
                          child: GestureDetector(
                            onTap: () {
                              changeScreen(context,
                                  InstructorProfileScreen(model: model[index]));
                            },
                            child: ItemHomeInstructor(
                              model: model[index],
                            ),
                          ),
                        ),
                      ),
                  itemCount: model.length,
                  options: animOption)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _upcomingLiveClass(
      {required int? userId,
      required List<UpcomingModel> model,
      required bool isLive}) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  child: Text(isLive ? "My Live Classes" : "My Demo Classes",
                      style: styleProvider())),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (userId != null) {
                        changeScreen(
                            context,
                            UpcomingLiveClasses(
                              userId: userId,
                              isLive: isLive,
                            ));
                      }
                    },
                    child: Text(
                      "View All",
                      style: styleProvider(
                          size: 10.0, color: Theme.of(context).hintColor),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    ic_arrow,
                    width: 15,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 110,
              alignment: Alignment.centerLeft,
              child: LiveList.options(
                  scrollDirection: Axis.horizontal,
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
                          child: GestureDetector(
                            onTap: () {
                              if (userId != null) {
                                if (isLive) {
                                  NumberFormat formatter =
                                      new NumberFormat("00");
                                  var currentDay = formatter
                                      .format(DateTime.now().day)
                                      .toString();
                                  var currentMonth =
                                      DateFormat("MMMM").format(DateTime.now());
                                  if (currentDay == model[index].date &&
                                      currentMonth.substring(0, 3) ==
                                          model[index].month) {
                                    changeScreen(
                                        context,
                                        LiveStreamingScreen(
                                          userId: userId,
                                          packageId: model[index].packageId!,
                                          isLive: true,
                                        ));
                                  }
                                }
                              }
                            },
                            child:
                                ItemHomeUpcomingLiveClass(model: model[index]),
                          ),
                        ),
                      ),
                  itemCount: model.length,
                  options: animOption)),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _review({required List<ReviewDetails> model}) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Reviews", style: styleProvider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      changeScreen(context, ReviewScreen());
                    },
                    child: Text("View All",
                        style: styleProvider(size: 10, color: grey)),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SvgPicture.asset(
                    ic_arrow,
                    width: 15,
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              height: 160,
              alignment: Alignment.centerLeft,
              child: LiveList.options(
                  scrollDirection: Axis.horizontal,
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
                          child: Container(
                              padding: EdgeInsets.only(right: 8),
                              child: ItemReview(
                                isHome: true,
                                model: model[index],
                              )),
                        ),
                      ),
                  itemCount: model.length,
                  options: animOption))
        ],
      ),
    );
  }

  late AppViewModel _appViewModel;
  @override
  Widget build(BuildContext context) {
    _appViewModel = MProvider.timeOffBlocOf(context);
    _appViewModel.getCartItemsCouunt();

    return BaseView<AppViewModel>(
        authRequired: true,
        onModelReady: (model, userId, userType) {
          model.setUserId(userId);
          _firebaseService = new FirebaseService();
          model.getHome(userId: userId!).then((value) => null).onError(
              (error, stackTrace) => _firebaseService.firebaseJsonError(
                  apiCall: "getHome",
                  message: error.toString(),
                  stackTrace: stackTrace,
                  userId: userId));
          model.setUserId(userId);
          // model.getCartItemsCouunt();
        },
        builder: (context, model, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 100),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: SafeArea(
                  child: Container(
                    color: Theme.of(context).backgroundColor,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (model.userId != null) {
                              printLog("njknjnjknj", model.userId!);
                              changeScreen(
                                  context,
                                  DrawerBuilder(
                                    userId: model.userId!,
                                  ));
                            }
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: Theme.of(context).highlightColor,
                            child: Icon(
                              CustomIcons.menu,
                              size: 8,
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                        ),
                        Text(
                          model.homeModel.homeData != null
                              ? model.homeModel.homeData!.greetings ??
                                  "Good Morning"
                              : "Good Morning",
                          style: styleProvider(),
                        ),
                        GestureDetector(
                          onTap: () {
                            // changeScreen(context, CartScreen());
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen()))
                                .then((value) {
                              _appViewModel.cartItemCount;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: Theme.of(context).highlightColor,
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(Icons.shopping_bag_outlined),
                                ),
                                _appViewModel.cartItemCount == 0
                                    ? SizedBox()
                                    : Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                            height: 14,
                                            width: 14,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: red),
                                            child: Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Text(
                                                "${_appViewModel.cartItemCount}",
                                                style: styleProvider(size: 8),
                                              ),
                                            )))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: _homeUiBuilder(model: model, userId: model.userId ?? null),
          );
        });
  }
}
