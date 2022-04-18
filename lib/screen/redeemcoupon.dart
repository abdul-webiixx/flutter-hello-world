import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/utils/widget_helper.dart';

class RedeemCouponScreen extends StatefulWidget {
  final CouponDetails model;
  RedeemCouponScreen({Key? key, required this.model});
  @override
  _RedeemCouponScreenState createState() => _RedeemCouponScreenState();
}

class _RedeemCouponScreenState extends State<RedeemCouponScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context).backgroundColor,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        appBar: BaseAppBar(),
        body: Container(
          color: Theme.of(context).backgroundColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Redeem your coupon code here",
                style: styleProvider(size: 18, fontWeight: semiBold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your coupon code below"
                " to extend subscription",
                style: styleProvider(
                  size: 14,
                  fontWeight: extraLight,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).highlightColor,
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).highlightColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).highlightColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: widget.model.couponCode),
                  keyboardType: TextInputType.text,
                  style: styleProvider(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColorLight),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {},
                title: "APPLY",
              )
            ],
          ),
        ),
      ),
    );
  }
}
