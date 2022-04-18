import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/coupon.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_coupon_details.dart';
import 'cart.dart';
import 'oops.dart';

class CouponDetailsScreen extends StatefulWidget {
  final int userId;
  CouponDetailsScreen({Key? key, required this.userId}) : super(key: key);
  @override
  _CouponDetailsScreenState createState() => _CouponDetailsScreenState();
}

class _CouponDetailsScreenState extends State<CouponDetailsScreen> {

  late List<CouponDetails> couponList;


  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(
        onModelReady: (model, userId, userType){
          model.getCouponData();
        },
        builder: (context, model, child){
      return Scaffold(
      appBar: BaseAppBar(isLeading: true, title: "Coupons",),
      body: _couponListProvider(model),
    );});
  }
  Widget _couponListProvider(CartViewModel provider){
    if(provider.couponModel.success!=null && provider.couponModel.success &&
        provider.couponModel.requestStatus == RequestStatus.loaded){
      return _couponListBuilder(model: provider.couponModel);
    }else if( provider.couponModel.requestStatus == RequestStatus.loading
    ){
      return LoadingProgress();
    }else{
      return SomethingWentWrong(status: getResponse(provider.couponModel.requestStatus));
    }
  }
  Widget _couponListBuilder({required CouponModel model}){
    return Container(
      child: model.couponDetails!=null && model.couponDetails!.length>0
          ? LiveList.options(
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
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 7),
                child: MaterialButton(
                  onPressed: (){
                    changeScreen(context, CartScreen());
                  },
                  padding: EdgeInsets.zero,
                  child: ItemCouponDetails(model: model.couponDetails![index]),
                ),
              ),
            ),
          ), itemCount: model.couponDetails!.length, options: animOption) : DataNotFound(),
    );
  }
}
