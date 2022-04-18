import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/order_summary.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:Zenith/services/firebase.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

import 'oops.dart';

class OrderSummaryScreen extends StatefulWidget {
  final int userId;
  final int orderId;
  OrderSummaryScreen({Key? key, required this.userId, required this.orderId})
      : super(key: key);

  @override
  _OrderSummaryScreenState createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late FirebaseService _firebaseService;

  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(onModelReady: (model, userId, userType) {
      model
          .getOrderSummary(userId: widget.userId, orderId: widget.orderId)
          .then((value) => null)
          .onError((error, stackTrace) {
        _firebaseService.firebaseJsonError(
            apiCall: "fetchOrderSummary",
            userId: widget.userId,
            stackTrace: stackTrace,
            message: error.toString());
      });
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          title: "Order Summary",
          isLeading: true,
        ),
        body: _pageProvider(model),
      );
    });
  }

  Widget _pageProvider(CartViewModel provider) {
    if (provider.orderSummaryModel.success != null &&
        provider.orderSummaryModel.success &&
        provider.orderSummaryModel.requestStatus == RequestStatus.loaded) {
      return _pageBuilder(model: provider);
    } else if (provider.orderSummaryModel.requestStatus ==
        RequestStatus.loading) {
      return LoadingProgress();
    } else {
      return SomethingWentWrong(
          status: getResponse(provider.orderSummaryModel.requestStatus));
    }
  }

  Widget _pageBuilder({required CartViewModel model}) {
    if (model.orderSummaryModel.orderSummaryData!.orderPlacedDetails != null &&
        model.orderSummaryModel.orderSummaryData!.orderItems != null &&
        model.orderSummaryModel.orderSummaryData!.orderItems!.length > 0) {
      return _pageDetails(model);
    } else {
      return DataNotFound(
        isButton: false,
      );
    }
  }

  Widget _pageDetails(CartViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Status :",
                    style: styleProvider(fontWeight: thin, size: 12),
                  ),
                  Text(
                    "${model.orderSummaryModel.orderSummaryData!.orderPlacedDetails!.orderStatus}",
                    style: styleProvider(
                        fontWeight: thin,
                        size: 12,
                        color: colorUpdater(
                            status: model.orderSummaryModel.orderSummaryData!
                                .orderPlacedDetails!.orderStatus!)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _orderItem(model.orderSummaryModel.orderSummaryData!.orderItems!),
            SizedBox(
              height: 20,
            ),
            _orderSummary(
                model.orderSummaryModel.orderSummaryData!.orderPlacedDetails!),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                onPressed: () {
                  model
                      .getInvoiceData(
                          userId: widget.userId, orderId: widget.orderId)
                      .then((value) {
                    if (value.requestStatus == RequestStatus.loaded &&
                        value.data != null) {
                      _launchBrowser(value.data!.link!);
                    }
                  }).onError((error, stackTrace) {
                    _firebaseService.firebaseJsonError(
                        apiCall: "fetchInvoiceData",
                        message: error.toString(),
                        stackTrace: stackTrace,
                        userId: widget.userId);
                  });
                },
                title: "DOWNLOAD INVOICE"),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _orderItem(List<OrderItem> list) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  color: highlightColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Id :",
                        style: styleProvider(
                            fontWeight: thin, size: 12, color: grey),
                      ),
                      Text("#${list[index].orderId}",
                          style: styleProvider(
                            fontWeight: thin,
                            size: 12,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date :",
                        style: styleProvider(
                            fontWeight: thin, size: 12, color: grey),
                      ),
                      Text("${dateFormatter(list[index].updatedAt!)}",
                          style: styleProvider(
                            fontWeight: thin,
                            size: 12,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Name :",
                        style: styleProvider(
                            fontWeight: thin, size: 12, color: grey),
                      ),
                      Text("${list[index].productTitle}",
                          style: styleProvider(
                            fontWeight: thin,
                            size: 12,
                          ))
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget _orderSummary(OrderPlacedDetails orderPlacedDetails) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          color: highlightColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal :",
                style: styleProvider(
                  color: grey,
                  fontWeight: thin,
                  size: 12,
                ),
              ),
              Text("#${orderPlacedDetails.orderSubTotal}",
                  style: styleProvider(
                    fontWeight: thin,
                    size: 12,
                  ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tax :",
                style: styleProvider(
                  color: grey,
                  fontWeight: thin,
                  size: 12,
                ),
              ),
              Text("#${orderPlacedDetails.tax}",
                  style: styleProvider(
                    fontWeight: thin,
                    size: 12,
                  ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Total :",
                style: styleProvider(
                  fontWeight: thin,
                  size: 12,
                ),
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
                child: Text("₹ ${orderPlacedDetails.orderTotal}",
                    textAlign: TextAlign.center,
                    style: styleProvider(
                        size: 12, color: Theme.of(context).backgroundColor)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Color colorUpdater({required String status}) {
    Color temp = Colors.green;
    switch (status) {
      case "Success":
        temp = Colors.green;
        break;
      case "Pending":
        temp = Colors.amber;
        break;
      case "Failed":
        temp = Colors.red;
        break;
    }
    return temp;
  }

  Future<void> _launchBrowser(String url) async {
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }
}
