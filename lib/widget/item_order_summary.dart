import 'package:flutter/material.dart';
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';

class ItemOrderSummary extends StatefulWidget {
  final OrderSummary orderSummary;
  final CouponDetails? couponDetails;
  const ItemOrderSummary(
      {Key? key, this.couponDetails, required this.orderSummary})
      : super(key: key);

  @override
  _ItemOrderSummaryState createState() => _ItemOrderSummaryState();
}

class _ItemOrderSummaryState extends State<ItemOrderSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order Summary',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14)),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text('Subtotal :',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ),
              Text("₹ ${widget.orderSummary.subTotal!.toString()}",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text('Tax :',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ),
              Text("₹ ${widget.orderSummary.tax!.toString()}",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: widget.couponDetails != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: RichText(
                        text: TextSpan(
                            text: "Total Discount: ",
                            style: styleProvider(size: 12),
                            children: [
                      TextSpan(
                          text: widget.couponDetails != null
                              ? "${discountFilter(widget.couponDetails!)}"
                              : "",
                          style: styleProvider(
                              size: 12, color: Theme.of(context).primaryColor)),
                    ]))),
                Text("₹ ${widget.orderSummary.discount!.toString()} ",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 12)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            height: 0.9,
            color: Theme.of(context).primaryColorLight,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 70,
                child: Text('Total :',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 12)),
              ),
              Text("₹ ${widget.orderSummary.total!.toString()}",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  String discountFilter(CouponDetails model) {
    if (model.discountType != null && model.discountType == "percent") {
      return "{${model.couponAmount} % OFF}";
    } else
      return "";
  }
}
