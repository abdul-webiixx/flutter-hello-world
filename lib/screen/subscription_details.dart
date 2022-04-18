import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/view_model/cart_view_model.dart';

import 'package:flutter/material.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/color.dart';
import 'package:Zenith/model/subscription.dart';
import 'package:Zenith/utils/size_config.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';

class SubscriptionsDetailsScreen extends StatefulWidget {
  final SubscriptionDetails? subscriptionDetails;
  SubscriptionsDetailsScreen({Key? key, required this.subscriptionDetails})
      : super(key: key);

  @override
  _SubscriptionsDetailsScreenState createState() =>
      _SubscriptionsDetailsScreenState();
}

class _SubscriptionsDetailsScreenState
    extends State<SubscriptionsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CartViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(isLeading: true, title: "Subscription Details"),
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Theme.of(context).highlightColor,
          ),
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth! / 2 - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: styleProvider(
                                color: grey, fontWeight: regular, size: 12),
                          ),
                          Text(
                            widget.subscriptionDetails!.name!,
                            style: styleProvider(
                                color: primaryColor,
                                fontWeight: regular,
                                size: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: SizeConfig.screenWidth! / 2 - 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Type",
                            style: styleProvider(
                                color: grey, fontWeight: regular, size: 12),
                          ),
                          Text(
                            widget.subscriptionDetails!.featuresName!,
                            style: styleProvider(
                                color: white, fontWeight: regular, size: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth! / 2 - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Date",
                            style: styleProvider(
                                color: grey, fontWeight: regular, size: 12),
                          ),
                          Text(
                            dateFormatter(
                                widget.subscriptionDetails!.startsAt!),
                            style: styleProvider(
                                color: white, fontWeight: regular, size: 14),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: SizeConfig.screenWidth! / 2 - 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "End date",
                            style: styleProvider(
                                color: grey, fontWeight: regular, size: 12),
                          ),
                          Text(
                            dateFormatter(widget.subscriptionDetails!.endsAt!),
                            style: styleProvider(
                                color: white, fontWeight: regular, size: 14),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
