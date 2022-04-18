
import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/utils/custom_icons.dart';
import 'package:Zenith/utils/widget_helper.dart';

Widget widgetPromoCode(BuildContext context,
    { CouponDetails? coupon, required GestureTapCallback onClick, GestureTapCallback? onCouponRemove}) {
  return GestureDetector(
    onTap: onClick,
    child: Card(
      elevation: 2,
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                amber_700!,
                amber_500!
              ]),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Expanded(
                child: Row(
                  children: [
                    Icon(
                      CustomIcons.coupons,
                      size: 15,
                      color: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width/1.75,
                      child: Text(
                        coupon!=null ? "Coupon Applied:- '${coupon.couponCode!.toUpperCase()}'" :
                        "Apply Coupon",
                        style: styleProvider(
                            size: 13,
                            color: Theme.of(context).backgroundColor,
                            fontWeight: medium),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onCouponRemove,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Icon(
                  coupon!=null ? Icons.close : Icons.arrow_forward_ios_rounded,
                  size: 15,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}