import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/offline_class_package.dart';
import 'package:Zenith/screen/cart.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/widget/item_offline_package.dart';

class OfflineServiceTypeScreen extends StatefulWidget {
  final int serviceId;
  final int classId;
  final String title;
  final String type;
  OfflineServiceTypeScreen(
      {Key? key,
      required this.serviceId,
      required this.classId,
      required this.title,
      required this.type})
      : super(key: key);

  @override
  _OfflineServiceTypeScreenState createState() =>
      _OfflineServiceTypeScreenState();
}

class _OfflineServiceTypeScreenState extends State<OfflineServiceTypeScreen> {
  late CartViewModel _cartViewModel;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      _cartViewModel = Provider.of<CartViewModel>(context, listen: false);
      model.getOfflineServiceTypeData(
          type: widget.type,
          classId: widget.classId,
          serviceId: widget.serviceId);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
          title: widget.title,
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          child: _listPackageProvider(model),
        ),
      );
    });
  }

  Widget _listPackageProvider(ClassViewModel provider) {
    if (provider.offlineClassPackageModel.success != null &&
        provider.offlineClassPackageModel.success) {
      return _pageBuilder(model: provider);
    } else if (provider.offlineClassPackageModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.offlineClassPackageModel.requestStatus));
    }
  }

  Widget _pageBuilder({required ClassViewModel model}) {
    if (model.offlineClassPackageModel.offlineClassPackageData != null &&
        model.offlineClassPackageModel.offlineClassPackageData!
                .offlineClassPackageDetails !=
            null &&
        model.offlineClassPackageModel.offlineClassPackageData != null &&
        model.offlineClassPackageModel.offlineClassPackageData!
                .offlineClassPackageDetails!.length >
            0) {
      return _listPackage(
          userId: model.userId,
          list: model.offlineClassPackageModel.offlineClassPackageData!
              .offlineClassPackageDetails!,
          productType: model.offlineClassPackageModel.productType!,
          centerId: model.centerId);
    } else {
      return DataNotFound();
    }
  }

  Widget _listPackage(
      {required int userId,
      required List<OfflineClassPackageDetails> list,
      required int productType,
      required int centerId}) {
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
                    _cartViewModel
                        .getAddToCart(
                            userId: userId,
                            productId: list[index].id!,
                            productType: productType,
                            price: list[index].amount!,
                            quantity: 1)
                        .then((value) {
                      showToast(context, msg: value.message!);
                      if (value.success) {
                        changeScreen(context, CartScreen());
                      }
                    });
                  },
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ItemClassPackageSubscriptions(
                    model: list[index],
                  ),
                ),
              ),
            ),
        itemCount: list.length,
        options: animOption);
  }
}
