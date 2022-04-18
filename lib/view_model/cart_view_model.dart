import 'dart:convert';
import 'dart:io';
import 'package:Zenith/base/base_model.dart';
import 'package:Zenith/utils/data_provider.dart';
import 'package:Zenith/utils/enum.dart';
import 'package:Zenith/constants/app_constants.dart';
import 'package:Zenith/constants/web_constants.dart';
import 'package:Zenith/model/api_response.dart';
import 'package:Zenith/utils/loading.dart';
import 'package:http/http.dart' as http;
import 'package:Zenith/model/cart.dart';
import 'package:Zenith/model/coupon.dart';
import 'package:Zenith/model/invoice.dart';
import 'package:Zenith/model/order.dart';
import 'package:Zenith/model/order_history.dart';
import 'package:Zenith/model/order_summary.dart';
import 'package:Zenith/model/subscription.dart';
import 'package:Zenith/services/cart.dart';
import 'package:Zenith/utils/request_failure.dart';
import 'package:Zenith/utils/token.dart';

class CartViewModel extends BaseModel {
  late ApiResponse _apiResponse;
  ApiResponse get apiResponse => _apiResponse;

  late int? _userId;
  int? get userId => _userId;

  late CartModel _cartModel;
  CartModel get cartModel => _cartModel;

  late CouponModel _couponModel;
  CouponModel get couponModel => _couponModel;

  late OrderModel _orderModel;
  OrderModel get orderModel => _orderModel;

  late OrderSummaryModel _orderSummaryModel;
  OrderSummaryModel get orderSummaryModel => _orderSummaryModel;

  late OrderHistoryModel _orderHistoryModel;
  OrderHistoryModel get orderHistoryModel => _orderHistoryModel;

  late SubscriptionModel _currentSubscriptionModel;
  SubscriptionModel get currentSubscriptionModel => _currentSubscriptionModel;

  late SubscriptionModel _pastSubscriptionModel;
  SubscriptionModel get pastSubscriptionModel => _pastSubscriptionModel;

  late InvoiceModel _invoiceModel;
  InvoiceModel get invoiceModel => _invoiceModel;

  late SubscriptionModel _waitListSubscriptionModel;
  SubscriptionModel get waitListSubscriptionModel => _waitListSubscriptionModel;

  late CartService _cartService;

  late Failure _failure;
  Failure get failure => _failure;

  CartViewModel.initializer() {
    _apiResponse = new ApiResponse();
    _cartModel = new CartModel();
    _couponModel = new CouponModel();
    _orderHistoryModel = new OrderHistoryModel();
    _orderModel = new OrderModel();
    _currentSubscriptionModel = new SubscriptionModel();
    _pastSubscriptionModel = new SubscriptionModel();
    _waitListSubscriptionModel = new SubscriptionModel();
    _cartService = new CartService();
    _orderSummaryModel = new OrderSummaryModel();
    _invoiceModel = new InvoiceModel();
    getUserId().then((value) {
      if (value != null) {
        _userId = value;
      }
    });
  }

  Future<ApiResponse> getAddToCart(
      {required int userId,
      required int productId,
      required int productType,
      required int quantity,
      required int price,
        String? days,
      int? centerId}) async {
    _apiResponse = new ApiResponse();
    final Uri url = Uri.parse(GetBaseUrl + GetDomainUrl + GetAddToCart);
    try {
      Map<String, dynamic> paramBody = {
        'user_id': userId.toString(),
        'product_id': productId.toString(),
        'product_type': productType.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
        'center': centerId.toString(),
        'days': days!=null ?  days.substring(1, days.length-1) : ""
      };
      printLog("getAddToCart-P", paramBody.toString());
      http.Response response =
          await http.post(url, headers: await authHeader(), body: paramBody);
      _apiResponse = new ApiResponse.fromJson(jsonDecode(response.body));
      if (response.statusCode == https_code_200 ||
          response.statusCode == https_code_201) {
        _apiResponse.requestStatus = RequestStatus.loaded;
      } else if (response.statusCode == https_code_404 ||
          response.statusCode == https_code_401) {
        _apiResponse.requestStatus = RequestStatus.unauthorized;
      } else if (response.statusCode == https_code_500) {
        _apiResponse.requestStatus = RequestStatus.server;
      }
    } on SocketException {
      throw Failure("No internet connection");
    } on HttpException {
      throw Failure("Bad Request Error");
    } on FormatException {
      throw Failure("Bad Format Error");
    }
    return _apiResponse;
  }

  Future<void> getCartData({required int userId}) async {
    _cartModel.requestStatus = RequestStatus.loading;
    notifyListeners();
    _cartModel = await _cartService.fetchCartData(userId: userId);
    notifyListeners();
  }

  Future<void> getProductRemoveFromCart(
      {required int userId, required int productId}) async {
    _cartModel.requestStatus = RequestStatus.loading;
    _cartModel = await _cartService.fetchProductRemoveFromCart(
        userId: userId, productId: productId);
    notifyListeners();
  }

  Future<void> getCouponData() async {
    _couponModel.requestStatus = RequestStatus.loading;
    _couponModel = await _cartService.fetchCouponData();
    notifyListeners();
  }

  Future<CartModel> getApplyCoupon(
      {required int userId, required String couponCode}) async {
    _cartModel.requestStatus = RequestStatus.loading;
    _cartModel = await _cartService.fetchApplyCoupon(
        userId: userId, couponCode: couponCode);
    notifyListeners();
    return _cartModel;
  }

  Future<CartModel> getRemoveCoupon({required int userId}) async {
    _cartModel.requestStatus = RequestStatus.loading;
    _cartModel = await _cartService.fetchRemoveCoupon(userId: userId);
    notifyListeners();
    return _cartModel;
  }

  Future<OrderModel> getCreateOrder(
      {required int userId,
      required String name,
      required String address1,
      required String address2,
      required String city,
      required String state,
      required String zip,
      required String gstNo}) async {
    _orderModel.requestStatus = RequestStatus.loading;
    _orderModel = await _cartService.fetchCreateOrder(
        userId: userId,
        name: name,
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        zip: zip,
        gstNo: gstNo);
    notifyListeners();
    return _orderModel;
  }

  Future<ApiResponse> getCreateConfirmation(
      {required int userId,
      required String orderId,
      required String status}) async {
    try {
      _apiResponse.requestStatus = RequestStatus.loading;
      _apiResponse = await _cartService.fetchCreateConfirmation(
          userId: userId, orderId: orderId, status: status);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
    }
    return _apiResponse;
  }

  Future<OrderSummaryModel> getOrderSummary(
      {required int userId, required int orderId}) async {
    try {
      _orderSummaryModel.requestStatus = RequestStatus.loading;
      _orderSummaryModel = await _cartService.fetchOrderSummary(
          userId: userId, orderId: orderId);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
    }
    return _orderSummaryModel;
  }

  Future<OrderHistoryModel> getOrderHistory({required int userId}) async {
    _orderHistoryModel.requestStatus = RequestStatus.loading;
    notifyListeners();
    _orderHistoryModel = await _cartService.fetchOrderHistory(userId: userId);
    notifyListeners();
    return _orderHistoryModel;
  }

  Future<SubscriptionModel> getCurrentSubscription(
      {required int userId}) async {
    _currentSubscriptionModel.requestStatus = RequestStatus.loading;
    _currentSubscriptionModel =
        await _cartService.fetchCurrentSubscription(userId: userId);
    notifyListeners();
    return _currentSubscriptionModel;
  }

  Future<SubscriptionModel> getPastSubscription({required int userId}) async {
    _pastSubscriptionModel.requestStatus = RequestStatus.loading;
    _pastSubscriptionModel =
        await _cartService.fetchPastSubscription(userId: userId);
    notifyListeners();
    return _pastSubscriptionModel;
  }

  Future<SubscriptionModel> getWaitListSubscription(
      {required int userId}) async {
    _waitListSubscriptionModel.requestStatus = RequestStatus.loading;
    _waitListSubscriptionModel =
        await _cartService.fetchWaitListSubscription(userId: userId);
    notifyListeners();
    return _waitListSubscriptionModel;
  }

  Future<InvoiceModel> getInvoiceData(
      {required int userId, required int orderId}) async {
    try {
      _invoiceModel.requestStatus = RequestStatus.loading;
      _invoiceModel =
          await _cartService.fetchInvoiceData(userId: userId, orderId: orderId);
      notifyListeners();
    } on Failure catch (e) {
      _setFailure(e);
    }
    return _invoiceModel;
  }

  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }
}
