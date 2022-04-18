import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/screen/cart.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'oops.dart';

class CouponsScreen extends StatefulWidget {
  final int userId;
  CouponsScreen({Key? key, required this.userId}) : super(key: key);
  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  late String code;
  late List<CouponDetails> couponList;

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(onModelReady: (model, userId, userType) {
      code = "enter your code here";
      couponList = [];
      model.getCouponData();
    }, builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: black,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Coupons",
                style: styleProvider(
                    size: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColorLight)),
            centerTitle: true,
          ),
          leading: backButton(),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Redeem your coupon code here",
                  style: styleProvider(size: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: SizeConfig.screenWidth! - 150,
                  child: Text(
                    "Enter your coupon code below to extend subscription",
                    textAlign: TextAlign.center,
                    style: styleProvider(size: 12, color: grey),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: SizeConfig.screenWidth!,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: const BoxDecoration(
                      color: highlightColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Text(
                    code,
                    textAlign: TextAlign.center,
                    style: styleProvider(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    getUserId().then((value) {
                      if (value != null) {
                        model
                            .getApplyCoupon(userId: value, couponCode: code)
                            .then((value) {
                          showToast(context, msg: value.message!);
                          model.getCouponData();
                          changeScreen(context, CartScreen());
                        });
                      }
                    });
                  },
                  title: "Apply Coupon",
                ),
                SizedBox(
                  height: 30,
                ),
                _listProvider(model)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget backButton() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                changeScreen(context, CartScreen());
              },
              child: Center(
                  child: Icon(
                CustomIcons.left_arrow,
                size: 12,
                color: Theme.of(context).primaryColorLight,
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget _listProvider(CartViewModel provider) {
    if (provider.couponModel.success != null && provider.couponModel.success) {
      couponList = provider.couponModel.couponDetails!;
      return _listCoupon(couponList: couponList);
    } else if (provider.couponModel.requestStatus == RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.couponModel.requestStatus));
    }
  }

  Widget _listCoupon({required List<CouponDetails> couponList}) {
    return Container(
      height: SizeConfig.screenHeight! - 400,
      child: GridView.builder(
          itemCount: couponList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (300 / 380),
          ),
          itemBuilder: (BuildContext context, int index) {
            return MaterialButton(
              onPressed: () {
                setState(() {
                  code = couponList[index].couponCode!;
                });
              },
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: SizeConfig.screenWidth!,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: const BoxDecoration(
                    color: highlightColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: const BoxDecoration(
                          color: black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                        "${couponList[index].couponAmount} %",
                        style: styleProvider(
                          size: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Code: ${couponList[index].couponCode}",
                        style: styleProvider(
                          size: 12,
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "min: ${couponList[index].minimumAmount != null ? couponList[index].minimumAmount : "NA"}",
                            style: styleProvider(
                              size: 10,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "max: ${couponList[index].maximumAmount != null ? couponList[index].maximumAmount : "NA"}",
                            style: styleProvider(
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
