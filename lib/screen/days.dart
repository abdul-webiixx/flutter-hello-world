import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/model/days.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/class_view_model.dart';
import 'package:Zenith/widget/item_days.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart.dart';

class DaysScreen extends StatefulWidget {
  final int classId;
  final int productId;
  final int price;
  final int productType;
  final int days;
  const DaysScreen(
      {Key? key,
      required this.classId,
      required this.productType,
      required this.productId,
      required this.price,
      required this.days})
      : super(key: key);

  @override
  _DaysScreenState createState() => _DaysScreenState();
}

class _DaysScreenState extends State<DaysScreen> {
  late List<String> dayList;
  late CartViewModel _cartViewModel;
  @override
  void initState() {
    dayList = [];
    _cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ClassViewModel>(onModelReady: (model, userId, userType) {
      model.getDays(classId: widget.classId);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: BaseAppBar(
          isLeading: true,
          title: "Days Selection",
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(child: _pageBuilder(model.daysModel)),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: CustomButton(
            title: 'NEXT',
            onPressed: () {
              setState(() {});
              if (dayList.length == widget.days) {
                _cartViewModel
                    .getAddToCart(
                        userId: model.userId,
                        productId: widget.productId,
                        productType: widget.productType,
                        quantity: 1,
                        days: dayList.toString(),
                        price: widget.price)
                    .then((value) {
                  showToast(context, msg: value.message!);
                  if (value.success) {
                    changeScreen(context, CartScreen());
                  }
                });
              } else {
                showToast(context,
                    msg: "You have ${widget.days} days to select");
              }
            },
          ),
        ),
      );
    });
  }

  Widget _pageBuilder(DaysModel model) {
    if (model.success == true) {
      return Wrap(
          runSpacing: 2,
          spacing: 4,
          alignment: WrapAlignment.center,
          children: List.generate(
              model.daysData!.length,
              (index) => ItemDays(
                    model: model.daysData![index],
                    isSelected: (bool value) {
                      super.setState(() {
                        if (value) {
                          dayList.add(model.daysData![index].day!);
                        } else {
                          dayList.remove(model.daysData![index].day!);
                        }
                      });
                    },
                  )));
    } else if (model.requestStatus == RequestStatus.loading) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LoadingView(
          msg: "Loading",
        ),
      );
    } else {
      return DataNotFound();
    }
  }

  void changeState(bool value) {}
}
