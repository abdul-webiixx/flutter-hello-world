import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/screen/redeemcoupon.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemCoupons extends StatelessWidget {
  final CouponDetails model;
  ItemCoupons({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.couponCode!,
                  style: styleProvider(size: 18, fontWeight: semiBold),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [amber_700!, amber_400!]),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    model.couponCode!,
                    style: styleProvider(
                        size: 10,
                        fontWeight: medium,
                        color: Theme.of(context).backgroundColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 100,
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Validity",
                          style: styleProvider(
                              color: Theme.of(context).hintColor,
                              fontWeight: regular,
                              size: 12),
                        ),
                        Text(
                          model.couponExpiryDate != null
                              ? model.couponExpiryDate
                              : "Unlimited",
                          style: styleProvider(
                              color: Theme.of(context).primaryColorLight,
                              fontWeight: regular,
                              size: 12),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 10,
                    thickness: 1,
                    color: Colors.white,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      changeScreen(
                          context,
                          RedeemCouponScreen(
                            model: model,
                          ));
                    },
                    child: Text(
                      "Apply",
                      style: styleProvider(
                          color: Theme.of(context).primaryColor,
                          size: 18,
                          fontWeight: medium),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
