import 'package:Zenith/base/base_view.dart';
import 'package:Zenith/model/auth_key.dart';
import 'package:Zenith/view_model/app_view_model.dart';
import 'package:Zenith/view_model/cart_view_model.dart';
import 'package:Zenith/view_model/user_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zenith/base/app_bar.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/model/coupon_details.dart';
import 'package:Zenith/model/order.dart';
import 'package:Zenith/model/sign_up.dart';
import 'package:Zenith/model/state.dart';
import 'package:Zenith/screen/oops.dart';
import 'package:Zenith/services/razorpay.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:Zenith/utils/widget_helper.dart';
import 'package:Zenith/validator/validate.dart';
import 'package:Zenith/widget/item_state_dropdown_menu.dart';
import 'package:Zenith/widget/item_order_summary.dart';

class PaymentScreen extends StatefulWidget {
  final OrderSummary orderSummary;
  final CouponDetails? couponDetails;
  PaymentScreen({Key? key, required this.orderSummary, this.couponDetails})
      : super(key: key);
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int checkedIndex = -1;
  int stepper = 0;
  bool checked = false;
  StateListItem? selectedItem;
  List<Widget> listPaymentMethod = [
    CachedNetworkImage(
      imageUrl: razorpayUrl,
      placeholder: (context, url) => Container(),
      errorWidget: (context, url, error) => Image.asset(
        moke_image1,
        fit: BoxFit.fill,
      ),
    ),
  ];
  late AppViewModel _appProvider;
  late UserViewModel _userProvider;
  late CartViewModel _cartProvider;
  late OrderDetails _orderDetails;
  late int userId;
  late RazorPaymentService razorPaymentService;
  @override
  void initState() {
    _appProvider = Provider.of<AppViewModel>(context, listen: false);
    _userProvider = Provider.of<UserViewModel>(context, listen: false);
    _cartProvider = Provider.of<CartViewModel>(context, listen: false);
    razorPaymentService = new RazorPaymentService();
    _orderDetails = new OrderDetails();
    getUserId().then((value) {
      if (value != null) {
        userId = value;
        _appProvider.getStateList().then((value) => null);
        _userProvider.getProfileData(userId: userId).then((value) {
          _userProvider.nameController.text = value.userInformation!.name!;
          _userProvider.address1Controller.text =
              value.userInformation!.address1 != null
                  ? value.userInformation!.address1
                  : "";
          _userProvider.address2Controller.text =
              value.userInformation!.address2 != null
                  ? value.userInformation!.address2
                  : "";
          _userProvider.cityController.text =
              value.userInformation!.city != null
                  ? value.userInformation!.city
                  : "";
          _userProvider.zipCodeController.text =
              value.userInformation!.zip != null
                  ? value.userInformation!.zip
                  : "";
          _userProvider.stateController.text =
              value.userInformation!.state != null
                  ? getStateNameProvider(code: value.userInformation!.state)
                  : "";
          _userProvider.emailController.text =
              value.userInformation!.email != null
                  ? value.userInformation!.email!
                  : "";
          _userProvider.gstController.text =
              value.userInformation!.gstNo != null
                  ? value.userInformation!.gstNo!
                  : "";
          _userProvider.mobileController.text =
              value.userInformation!.mobile != null
                  ? value.userInformation!.mobile!
                  : "9999999999";
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AppViewModel>(
        authRequired: true,
        onModelReady: (model, userId, userType) {
          model.getRazorAuthKey(userId: userId!);
        },
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: BaseAppBar(title: "Payment", isLeading: true),
            body: SingleChildScrollView(
              child: Container(
                child: stepper == 0
                    ? _detailsProvider()
                    : _paymentDetails(
                        widget.orderSummary, widget.couponDetails),
              ),
            ),
            bottomNavigationBar: CustomButton(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              onPressed: () {
                if (stepper == 0) {
                  printLog("bjkbjkbbj", "msg");
                  if (formValidator()) {
                    printLog("bjkbjkbbj", "msg1");
                    _cartProvider
                        .getCreateOrder(
                            userId: userId,
                            name: _userProvider.nameController.text,
                            address1: _userProvider.address1Controller.text,
                            address2: _userProvider.address2Controller.text,
                            city: _userProvider.cityController.text,
                            state: _userProvider.stateController.text,
                            gstNo: _userProvider.gstController.text,
                            zip: _userProvider.zipCodeController.text)
                        .then((value) {
                      printLog("bjkbjkbbj", value.toJson());
                      if (value.success != null && value.success) {
                        setState(() {
                          _orderDetails = value.orderDetails!;
                        });
                        stepper++;
                      } else {
                        showToast(context, msg: value.message ?? network_error);
                      }
                    });
                  }
                } else {
                  paymentProcessor(checkedIndex, model.authKeyModel);
                }
              },
              title: stepper == 0 ? "Next" : "Pay Now",
            ),
          );
        });
  }

  Widget _listPaymentMethods(List<Widget> list) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(1),
        height: 80,
        alignment: Alignment.center,
        child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              checked = index == checkedIndex;
              return Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            checkedIndex = index;
                          });
                        },
                        child: Container(
                            width: 130,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: checked
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).highlightColor),
                              color: Theme.of(context).highlightColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Center(
                              child: list[index],
                            ))),
                  ),
                  Visibility(
                      visible: checked,
                      child: Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).highlightColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: Icon(
                              Icons.check_circle,
                              size: 20,
                              color: Theme.of(context).primaryColor,
                            )),
                      ))
                ],
              );
            }));
  }

  Widget _paymentDetails(
      OrderSummary orderSummary, CouponDetails? couponDetails) {
    return Container(
      child: Column(
        children: [
          ItemOrderSummary(
            orderSummary: orderSummary,
            couponDetails: couponDetails,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Payment Methods",
            style: styleProvider(size: 14, fontWeight: medium),
          ),
          _listPaymentMethods(listPaymentMethod),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _billingDetails({required UserInformation model}) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Billing Details",
            style: styleProvider(size: 16, fontWeight: medium),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Full Name",
            style: styleProvider(size: 14, fontWeight: regular),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: ""),
              controller: _userProvider.nameController,
              keyboardType: TextInputType.text,
              style: styleProvider(
                  fontWeight: FontWeight.w300,
                  size: 14,
                  color: Theme.of(context).primaryColorLight),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Address 1",
            style: styleProvider(size: 14, fontWeight: regular),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "type here"),
              controller: _userProvider.address1Controller,
              keyboardType: TextInputType.text,
              style: styleProvider(
                  fontWeight: FontWeight.w300,
                  size: 14,
                  color: Theme.of(context).primaryColorLight),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Address 2",
            style: styleProvider(size: 14, fontWeight: regular),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "type here"),
              controller: _userProvider.address2Controller,
              keyboardType: TextInputType.text,
              style: styleProvider(
                  fontWeight: FontWeight.w300,
                  size: 14,
                  color: Theme.of(context).primaryColorLight),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "City",
            style: styleProvider(size: 14, fontWeight: regular),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "type here"),
              keyboardType: TextInputType.text,
              controller: _userProvider.cityController,
              style: styleProvider(
                  fontWeight: FontWeight.w300,
                  size: 14,
                  color: Theme.of(context).primaryColorLight),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "GST No (optional)",
            style: styleProvider(size: 14, fontWeight: regular),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: "type here"),
              keyboardType: TextInputType.text,
              controller: _userProvider.gstController,
              style: styleProvider(
                  fontWeight: FontWeight.w300,
                  size: 14,
                  color: Theme.of(context).primaryColorLight),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "State",
                      style: styleProvider(size: 14, fontWeight: regular),
                    ),
                    Center(
                      child: Container(
                        height: 45,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width / 2 - 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Theme.of(context).primaryColorLight,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: _stateListProvider(
                              state: _userProvider.stateController.text),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Zip Code",
                      style: styleProvider(size: 14, fontWeight: regular),
                    ),
                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width / 2 - 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).highlightColor,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 0),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "type here",
                            counterText: ""),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        controller: _userProvider.zipCodeController,
                        style: styleProvider(
                            fontWeight: FontWeight.w300,
                            size: 14,
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _stateListProvider({String? state}) {
    return new Consumer<AppViewModel>(
      builder: (context, provider, child) {
        if (provider.stateModel.success != null &&
            provider.stateModel.requestStatus == RequestStatus.loaded) {
          return StateListDropdown(
            defaultValue: selectedItem,
            stateList: provider.stateModel.states != null
                ? provider.stateModel.states
                : [],
            hint: "State",
            onChanged: (StateListItem model) {
              setState(() {
                _userProvider.stateController.text = model.id.toString();
              });
            },
          );
        } else if (provider.stateModel.requestStatus == RequestStatus.loading) {
          return LoadingProgress();
        } else {
          return Text("Select State");
        }
      },
    );
  }

  Widget _detailsProvider() {
    return new Consumer<UserViewModel>(builder: (context, provider, child) {
      if (provider.profileModel.success != null &&
          provider.profileModel.success) {
        return _billingDetails(model: provider.profileModel.userInformation!);
      } else if (provider.profileModel.requestStatus == RequestStatus.loading) {
        return LoadingProgress();
      } else {
        return SomethingWentWrong(
            status: getResponse(provider.profileModel.requestStatus));
      }
    });
  }

  bool formValidator() {
    bool status = true;
    if (!isValidString(_userProvider.nameController.value.text.trim()) ||
        !RegExp(r'^[a-zA-Z ]+$')
            .hasMatch(_userProvider.nameController.value.text.trim())) {
      status = false;
      showToast(context, msg: enter_user_name);
    } else if (!isValidString(
        _userProvider.address1Controller.value.text.trim())) {
      status = false;
      showToast(context, msg: in_complete_address1_error);
    } else if (!isValidString(
        _userProvider.address2Controller.value.text.trim())) {
      status = false;
      showToast(context, msg: in_complete_address2_error);
    } else if (!isValidString(_userProvider.cityController.value.text.trim())) {
      status = false;
      showToast(context, msg: in_complete_city_error);
    } else if (!isValidString(
            _userProvider.zipCodeController.value.text.trim()) ||
        !RegExp(r'^[1-9][0-9]{5}')
            .hasMatch(_userProvider.zipCodeController.value.text.trim())) {
      status = false;
      showToast(context, msg: in_complete_zip_error);
    } else if (!isValidString(
        _userProvider.stateController.value.text.trim())) {
      status = false;
      showToast(context, msg: in_complete_state_error);
    } else {
      status = true;
    }
    return status;
  }

  String getStateNameProvider({required int code}) {
    String state = "State";
    for (int i = 0; i < _appProvider.stateModel.states!.length; i++) {
      if (_appProvider.stateModel.states![i].id == code) {
        state = _appProvider.stateModel.states![i].name!;
      }
    }
    return state;
  }

  void paymentProcessor(int checkedIndex, AuthKeyModel model) {
    switch (checkedIndex) {
      case 0:
        if (model.data != null && isValidString(model.data!.key!)) {
          razorPaymentService.initPaymentGateway(
              context: context, orderId: _orderDetails.id!, userId: userId);
          razorPaymentService.getPayment(
              context: context,
              key: model.data!.key!,
              amount: "${_orderDetails.orderTotal! * 100}",
              name: _userProvider.nameController.text,
              email: _userProvider.emailController.text,
              mobile: _userProvider.mobileController.text,
              orderId: _orderDetails.id.toString());
        }
        break;
      case 1:
        showToast(context, msg: "This service is not available for now");
        break;
      default:
        showToast(context, msg: "Please select payment method...");
        break;
    }
  }
}
