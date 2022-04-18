import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/provider/cartIcon.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/course_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/course_package.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/widget/item_course_package.dart';
import 'cart.dart';

class CoursePackageScreen extends StatefulWidget {
  final int courseId;
  final String title;
  CoursePackageScreen({Key? key, required this.courseId, required this.title})
      : super(key: key);

  @override
  _CoursePackageScreenState createState() => _CoursePackageScreenState();
}

class _CoursePackageScreenState extends State<CoursePackageScreen> {
  late CartViewModel _cartViewModel;
  late AppViewModel _appViewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView<CourseViewModel>(onModelReady: (model, userId, userType) {
      _cartViewModel = Provider.of<CartViewModel>(context, listen: false);
      model.getCoursePackageData(courseId: widget.courseId);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          child: _listPackageProvider(model),
        ),
      );
    });
  }

  Widget _listPackageProvider(CourseViewModel provider) {
    if (provider.coursePackageModel.success != null &&
        provider.coursePackageModel.success) {
      return _pageBuilder(
          model: provider.coursePackageModel.coursePackageData!,
          userId: provider.userId);
    } else if (provider.coursePackageModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.coursePackageModel.requestStatus));
    }
  }

  Widget _pageBuilder({required CoursePackageData model, required int userId}) {
    if (model.coursePackageDetails != null &&
        model.coursePackageDetails!.length > 0) {
      return _listPackage(list: model.coursePackageDetails!, userId: userId);
    } else {
      return DataNotFound();
    }
  }

  Widget _listPackage(
      {required List<CoursePackageDetails> list, required int userId}) {
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
                    onPressed: () async {
                      _cartViewModel
                          .getAddToCart(
                              userId: userId,
                              productId: list[index].id!,
                              productType: list[index].productType!,
                              price: list[index].price!,
                              quantity: 1)
                          .then((value) {
                        showToast(context, msg: value.message!);
                        if (value.success) {
                          changeScreen(context, CartScreen());
                          _appViewModel = MProvider.timeOffBlocOf(context);

                          _appViewModel.cartItemCount! - 1;
                        }
                      });
                      // ItemCount.additemcount();
                      // var temp = await ItemCount.getIcondata;
                      // print(temp);
                      // model.getCartItemsCouunt(userId: userId);
                    },
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: ItemCoursePackageSubscriptions(
                      model: list[index],
                    ),
                  )),
            ),
        itemCount: list.length,
        options: animOption);
  }
}
