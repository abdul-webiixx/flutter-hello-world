import 'package:Zenith/utils/size_config.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemCouponDetails extends StatelessWidget {
  final CouponDetails model;
  ItemCouponDetails({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
          color: highlightColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: SizeConfig.heightMultiplier! * 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.couponCode!,
                  style: styleProvider(fontWeight: bold, size: 18),
                ),
                Container(
                  height: 20,
                  width: 100,
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFAE00),
                          Color(0xFFFFAE00),
                          Color(0xFFF9E866),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text("${model.couponCode}",
                      textAlign: TextAlign.center,
                      style: styleProvider(
                          size: 12, color: Theme.of(context).backgroundColor)),
                )
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Validity",
                      style: styleProvider(
                          color: grey, fontWeight: thin, size: 12),
                    ),
                    Text(
                      dateOnlyMonth(model.couponExpiryDate != null
                          ? model.couponExpiryDate
                          : DateTime(2022)),
                      style: styleProvider(fontWeight: thin, size: 12),
                    ),
                    Text(
                      dateWithOutMonthHeaded(model.couponExpiryDate != null
                          ? model.couponExpiryDate
                          : DateTime(2022)),
                      style: styleProvider(fontWeight: thin, size: 12),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 1,
                height: 50,
                color: white,
              ),
              Text(
                "APPLY",
                style: styleProvider(
                    size: 20, color: primaryColor, fontWeight: bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
