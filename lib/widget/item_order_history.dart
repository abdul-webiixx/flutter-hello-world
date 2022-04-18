import 'package:flutter/material.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/order.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class ItemOrderHistory extends StatelessWidget {
  final OrderDetails model;
  const ItemOrderHistory({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Status:",
                style: styleProvider(size: 14, fontWeight: medium),
              ),
              Text(
                "${model.orderStatus}",
                style: styleProvider(
                    size: 14,
                    fontWeight: medium,
                    color: colorUpdater(requestStatus: model.orderStatus!)),
              ),
            ],
          ),
          Divider(
            height: 2,
            color: white,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: SizeConfig.screenWidth! - 40,
            color: Theme.of(context).highlightColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: SizeConfig.screenWidth! / 2 - 60,
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Order Id:",
                            style: styleProvider(color: grey, size: 12),
                          ),
                          Text(
                            "#${model.id}",
                            style: styleProvider(size: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax:",
                            style: styleProvider(color: grey, size: 12),
                          ),
                          Text(
                            "₹ ${model.tax}",
                            style: styleProvider(size: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  width: SizeConfig.screenWidth! / 2 - 60,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date:",
                            style: styleProvider(color: grey, size: 12),
                          ),
                          Text(
                            "${dateFormatter(model.date!)}",
                            style: styleProvider(size: 12),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal:",
                            style: styleProvider(color: grey, size: 12),
                          ),
                          Text(
                            "₹ ${model.orderSubTotal}",
                            style: styleProvider(size: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order Total",
                  style: styleProvider(),
                ),
                Container(
                  height: 30,
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFFFFAE00),
                          Color(0xFFFFAE00),
                          Color(0xFFF9E866),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3.0))),
                  child: Text("₹ ${model.orderTotal}",
                      textAlign: TextAlign.center,
                      style: styleProvider(
                          fontWeight: semiBold,
                          size: 14,
                          color: Theme.of(context).backgroundColor)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Color colorUpdater({required String requestStatus}) {
    Color temp = Colors.green;
    switch (requestStatus) {
      case "Success":
        temp = Colors.green;
        break;
      case "Failed":
        temp = Colors.red;
        break;
      case "Pending":
        temp = Colors.amber;
        break;
    }
    return temp;
  }
}
