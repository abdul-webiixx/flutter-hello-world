import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/provider/cartIcon.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/screen/coupon.dart';
import 'package:Zenith/screen/payment.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/widget/item_cart.dart';
import 'package:Zenith/widget/item_order_summary.dart';
import 'package:Zenith/widget/item_promoCode.dart';
import 'package:provider/provider.dart';
import 'oops.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  late int userId;
  late AppViewModel _appViewModel;

  Widget cartDataBuilder({required CartViewModel model}) {
    return Container(
        color: Theme.of(context).backgroundColor,
        child: Scaffold(
          key: _key,
          appBar: BaseAppBar(
            title: "Order Summary",
            isLeading: true,
          ),
          body: buildUi(model: model),
          bottomNavigationBar: bottomBar(
              orderSummary: model.cartModel.cartData!.orderSummary!,
              couponDetails: model.cartModel.cartData!.couponDetails,
              isCartEmpty: model.cartModel.cartData!.cartItems != null &&
                  model.cartModel.cartData!.cartItems!.length > 0),
        ));
  }

  Widget bottomBar(
      {required OrderSummary orderSummary,
      CouponDetails? couponDetails,
      required bool isCartEmpty}) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Container(
        height: 50,
        width: SizeConfig.screenWidth!,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 10, top: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("₹ ${orderSummary.total!.toString()}",
                style: styleProvider(fontWeight: FontWeight.w600, size: 22)),
            Visibility(
                visible: isCartEmpty,
                child: GestureDetector(
                  onTap: () {
                    changeScreen(
                        context,
                        PaymentScreen(
                          orderSummary: orderSummary,
                          couponDetails: couponDetails,
                        ));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [amber_800!, amber_500!]),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text('PAY',
                        style: styleProvider(
                          color: Theme.of(context).backgroundColor,
                          fontWeight: medium,
                        )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget buildUi({required CartViewModel model}) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _itemList(model: model),
            _promoCodeMultiplier(model: model),
            SizedBox(
              height: 10,
            ),
            ItemOrderSummary(
              orderSummary: model.cartModel.cartData!.orderSummary!,
              couponDetails: model.cartModel.cartData!.couponDetails,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoCodeMultiplier({required CartViewModel model}) {
    if (model.cartModel.cartData!.couponDetails != null) {
      return widgetPromoCode(context,
          coupon: model.cartModel.cartData!.couponDetails, onClick: () {
        changeScreen(
            context,
            CouponsScreen(
              userId: model.userId!,
            ));
      }, onCouponRemove: () {
        model.getRemoveCoupon(userId: model.userId!);
      });
    } else {
      return widgetPromoCode(context, onClick: () {
        changeScreen(
            context,
            CouponsScreen(
              userId: model.userId!,
            ));
      });
    }
  }

  Widget _itemList({required CartViewModel model}) {
    return Container(
        child: model.cartModel.cartData!.cartItems!.length > 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: model.cartModel.cartData!.cartItems!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemCart(
                    item: model.cartModel.cartData!.cartItems![index],
                    onPressed: () async {
                      model.getProductRemoveFromCart(
                          userId: model.userId!,
                          productId: model.cartModel.cartData!.cartItems![index]
                              .productId!);

                      _appViewModel = MProvider.timeOffBlocOf(context);

                      _appViewModel.cartItemCount! - 1;

                      // ItemCount.reduceitemcount();
                      // var temp = await ItemCount.getIcondata;
                      // print(temp);
                    },
                  );
                })
            : CartEmpty());
  }

  @override
  Widget build(BuildContext context) {
    _appViewModel = MProvider.timeOffBlocOf(context);

    _appViewModel.getCartItemsCouunt();

    return BaseView<CartViewModel>(
        authRequired: true,
        onModelReady: (model, userId, userType) async {
          CartViewModel.initializer();
          model.getCartData(userId: userId!);
        },
        builder: (context, model, child) {
          if (model.cartModel.success != null &&
              model.cartModel.success &&
              model.cartModel.requestStatus == RequestStatus.loaded) {
            return cartDataBuilder(model: model);
          } else if (model.cartModel.requestStatus == RequestStatus.loading) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 100),
              child: LoadingProgress(),
            );
          } else {
            return SomethingWentWrong(
                status: getResponse(model.cartModel.requestStatus));
          }
        });
  }
}
