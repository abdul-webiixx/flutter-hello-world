import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/order_history.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/screen/order_summary.dart';
import 'package:Zenith/utils/animation_builder.dart';
import 'package:Zenith/utils/list_animation.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/widget/item_order_history.dart';

class OrderHistory extends StatefulWidget {
  final int userId;
  OrderHistory({Key? key, required this.userId}) : super(key: key);
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(onModelReady: (model, userId, userType) {
      model.getOrderHistory(userId: widget.userId);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          title: "Order History",
          isLeading: true,
        ),
        body: _listProvider(model),
      );
    });
  }

  Widget _listProvider(CartViewModel provider) {
    if (provider.orderHistoryModel.success != null &&
        provider.orderHistoryModel.success &&
        provider.orderHistoryModel.requestStatus == RequestStatus.loaded) {
      return _listBuilder(
          orderHistory: provider.orderHistoryModel.orderHistoryData!);
    } else if (provider.orderHistoryModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.orderHistoryModel.requestStatus));
    }
  }

  Widget _listBuilder({required OrderHistoryData orderHistory}) {
    return Container(
      child: orderHistory.orderList != null &&
              orderHistory.orderList!.length > 0
          ? LiveList.options(
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
                          changeScreen(
                              context,
                              OrderSummaryScreen(
                                  userId: widget.userId,
                                  orderId: orderHistory.orderList![index].id!));
                        },
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: ItemOrderHistory(
                          model: orderHistory.orderList![index],
                        ),
                      ),
                    ),
                  ),
              itemCount: orderHistory.orderList!.length,
              options: animOption)
          : DataNotFound(
              title: "Data Not Available",
              subTitle: "You do not have active subscriptions",
            ),
    );
  }
}
