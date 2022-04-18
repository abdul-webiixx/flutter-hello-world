import 'package:Zenith/screen/thank_you.dart';
import 'package:Zenith/utils/enum.dart';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/helper/screen_navigator.dart';
import 'package:Zenith/services/cart.dart';
import 'package:Zenith/utils/loading.dart';

class RazorPaymentService {
  Razorpay? _razorpay;
  late int orderId;
  late int userId;
  late BuildContext _context;
  late CartService _cartService;
  initPaymentGateway(
      {required BuildContext context,
      required int orderId,
      required int userId}) {
    this._context = context;
    this.orderId = orderId;
    this.userId = userId;
    _razorpay = new Razorpay();
    _cartService = new CartService();
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWallet);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, paymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, paymentError);
  }

  void externalWallet(ExternalWalletResponse response) {}

  void paymentSuccess(PaymentSuccessResponse response) {
    showToast(_context, msg: "Waiting for payment confirmation");
    changeScreen(_context, ThanksYouScreen(thanksFor: ThanksFor.Purchase));
    _cartService
        .fetchCreateConfirmation(
            userId: userId, orderId: orderId.toString(), status: "Success")
        .then((value) => null)
        .onError((error, stackTrace) => null);
  }

  void paymentError(PaymentFailureResponse response) {
    showToast(_context, msg: "payment failed");
  }

  getPayment(
      {BuildContext? context,
      required String key,
      required String amount,
      required String mobile,
      required String email,
      required String name,
      required String orderId}) {
    int netValue = int.parse(amount.replaceAll('.', ''));

    var options = {
      'id': orderId,
      'key': key,
      'amount': netValue,
      'name': appName,
      'description': appDes,
      'merchant_order_id': orderId,
      'prefill': {
        'contact': mobile,
        'email': email,
      },
      'theme': {"color": "#FFA500"}
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      printLog("_razorPaymentError", e);
    }
  }
}
